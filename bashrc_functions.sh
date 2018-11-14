NONE="\033[0m"    # unsets color to term's fg color

# regular colors
K="\033[0;30m"    # black
R="\033[0;31m"    # red
G="\033[0;32m"    # green
Y="\033[0;33m"    # yellow
B="\033[0;34m"    # blue
M="\033[0;35m"    # magenta
C="\033[0;49;96m" # cyan
W="\033[0;37m"    # white

# emphasized (bolded) colors
EMK="\033[1;30m"
EMR="\033[1;31m"
EMG="\033[1;32m"
EMY="\033[1;33m"
EMB="\033[1;34m"
EMM="\033[1;35m"
EMC="\033[1;49;96m"
EMW="\033[1;37m"

# background colors
BGK="\033[40m"
BGR="\033[41m"
BGG="\033[42m"
BGY="\033[43m"
BGB="\033[44m"
BGM="\033[45m"
BGC="\033[46m"
BGW="\033[47m"

colors() {
	printf "\n${NONE}Foreground color codes:\n"
	printf "${NONE}{NONE}" && echo "	${NONE}"
	printf "${W}{W}" && echo -n "	${W}" && printf "${EMW}	{EMW}	${EMW}\n"
	printf "${B}{B}" && echo -n "	${B}" && printf "${EMB}	{EMB}	${EMB}\n"
	printf "${G}{G}" && echo -n "	${G}" && printf "${EMG}	{EMG}	${EMG}\n"
	printf "${C}{C}" && echo -n "	${C}" && printf "${EMC}	{EMG}	${EMC}\n"
	printf "${R}{R}" && echo -n "	${R}" && printf "${EMR}	{EMR}	${EMR}\n"
	printf "${M}{M}" && echo -n "	${M}" && printf "${EMM}	{EMM}	${EMM}\n"
	printf "${Y}{Y}" && echo -n "	${Y}" && printf "${EMY}	{EMY}	${EMY}\n"
	printf "${K}{K}" && echo -n "	${K}" && printf "${EMK}	{EMK}	${EMK}\n"
	printf "\n${NONE}Background color codes:\n"
	printf "${NONE}${BGK}{BGK}" 		&& echo -n "	${BGK}" && printf "${NONE}\n"
	printf "${NONE}${BGR}{BGR}" 		&& echo -n "	${BGR}" && printf "${NONE}\n"
	printf "${NONE}${K}${BGG}{BGG}" && echo -n "	${BGG}" && printf "${NONE}\n"
	printf "${NONE}${K}${BGY}{BGY}" && echo -n "	${BGY}" && printf "${NONE}\n"
	printf "${NONE}${BGB}{BGB}" 		&& echo -n "	${BGB}" && printf "${NONE}\n"
	printf "${NONE}${BGM}{BGM}" 		&& echo -n "	${BGM}" && printf "${NONE}\n"
	printf "${NONE}${K}${BGC}{BGC}" && echo -n "	${BGC}" && printf "${NONE}\n"
	printf "${NONE}${K}${BGW}{BGW}" && echo -n "	${BGW}" && printf "${NONE}\n"
}

colors.256() {
	for fgbg in 38 48 ; do
		for color in {0..256} ; do
			printf "\e[${fgbg};5;${color}m ${color}\t\e[0m"
			if [ $((($color + 1) % 10)) == 0 ] ; then
				printf "\n"
			fi
		done
		echo
	done
}

colors.codes() {
	for clbg in {40..47} {100..107} 49 ; do
		for clfg in {30..37} {90..97} 39 ; do
			for attr in 0 1 2 4 5 7 ; do
				printf "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
			done
			echo
		done
	done
}

bash_prompt_command() {
    RETURN=$?
    # How many characters of the $PWD should be kept
    local pwdmaxlen=45
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]; then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
    history -a
    #EXIT_CODE='$(if [[ $RETURN = 0 ]]; then echo -ne ""; else echo -ne "\[$EMR\]$RETURN\[$NONE\] "; fi;)'
}

prompt.vcs.enable(){
    PROMPT_VCS=1
}
prompt.vcs.disable(){
    PROMPT_VCS=0
}

vcs(){
    [ $PROMPT_VCS -eq "1" ] && echo -e $(vcprompt -f "${K} %n[${R}%b${EMG}%m${EMR}%u${K}]")
}

bash_prompt() {
    case $TERM in
        xterm*|rxvt*)
            local TITLEBAR='\[\033]0;${SHORT_HOST} ${NEW_PWD}\007\]';;
        *)
            local TITLEBAR="";;
    esac

    local UC=$W                    # user's color
    [ $UID -eq 0 ] && UC=$EMR      # root's color

    local ARROW_COLOR=$EMR
    [ $? -eq 0 ] && ARROW_COLOR=$EMG

    PS1="\[${TITLEBAR}\
    ${UC}\u\
    \$(vcs) \
    ${EMB}\${NEW_PWD} \
    ${K} \
    \[${NONE}\]\n\[${ARROW_COLOR}\]→ \[${NONE}\]"
}

function varSwitch() {
	#local varswitch_toggleopts=("next" "previous" "random" "off" "first" "last" "toggle")
	# next will get the next value from options
	# previous will get the previous value from options
	# ramdom will generate a random value from options
	# off will unset the variable
	# first will get the first option from options
	# last will get the last option from options
	# toggle will switch between 2 arguments from the options
	declare -a varswitch_options=("${!1}")
	varswitch_currentvar="${2}"
	varswitch_toggleto="${3}"
    index=0

	if [ "${varswitch_toggleto}" == "next" ]; then
        while [ "$index" -lt "${#varswitch_options[@]}" ]; do
            if [ "${varswitch_options[$index]}" = "$varswitch_currentvar" ]; then
                index=$((index + 1))
                break
            fi
            # Wrap around if at the end of the array
            if [ "$index" -eq "${#varswitch_options[@]}" ]; then
                index=0
                break
            else
                let "index++"
            fi
        done

        varswitch_newvar=${varswitch_options[$index]}
        if [ -z "$varswitch_newvar" ]; then
            echo "Value was not found in array"
        else
            echo $varswitch_newvar
        fi
	elif [ "${varswitch_toggleto}" == "previous" ]; then
        while [ "$index" -lt "${#varswitch_options[@]}" ]; do
            if [ "${varswitch_options[$index]}" = "$varswitch_currentvar" ]; then
                index=$(index - 1)
                break
            fi
            # Wrap around if at the end of the array
            if [ "$index" -eq "${#varswitch_options[@]}" ]; then
                index="${#varswitch_options[@]}"
                break
            else
                let "index++"
            fi
        done

        varswitch_newvar=${varswitch_options[$index]}
        if [ -z "$varswitch_newvar" ]; then
            echo "Value was not found in array"
        else
            echo $varswitch_newvar
        fi
	elif [ "${varswitch_toggleto}" == "random" ]; then
        RANDOM=$$$(date +%s)
        varswitch_newvar=${varswitch_options[$RANDOM % ${#varswitch_options[@]}]}

        echo $varswitch_newvar
	elif [ "${varswitch_toggleto}" == "off" ]; then
		keys=("${!a[@]}")
        for i in "${keys[@]::2}"; do unset "varswitch_options[$i]"; done
    elif [ "${varswitch_toggleto}" == "remove" ]; then
        for target in "${varswitch_currentvar}"; do
            for i in "${!varswitch_options[@]}"; do
                if [[ ${varswitch_options[i]} = "${varswitch_currentvar}" ]]; then
                    unset "varswitch_options[i]"
                fi
            done
        done
        for i in "${!varswitch_options[@]}"; do
            new_array+=( "${varswitch_options[i]}" )
        done
        varswitch_options=("${new_array[@]}")
        echo ${varswitch_options[@]}
        unset new_array
	elif [ "${varswitch_toggleto}" == "first" ]; then
		varswitch_newvar=${varswitch_options[0]}
        echo $varswitch_newvar
	elif [ "${varswitch_toggleto}" == "last" ]; then
        varswitch_newvar=${varswitch_options[${#varswitch_options[@]}-1]}
		echo $varswitch_newvar
	elif [ "${varswitch_toggleto}" == "toggle" ]; then
		return $varswitch_variable
    else
        echo "invalid varSwitch format"
	fi
}
