DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/bashrc_functions.sh"
#trap '' SIGINT SIGQUIT SIGTSTP

pause() {
	echo -e "${R}Press ${EMR}[${EMW}Enter${EMR}] ${R}key to continue${EMK}..."${NONE}
	read fackEnterKey
}

menu1Opt1() {
	options=(
		"Number 1"
		"Number 2"
		"Number 3"
		"Number 4"
	)

	# Test ingnext var in array
	echo -e "${EMW}options${EMK}=${EMC}(${R}\"${W}Number 1${R}\" ${R}\"${W}Number 2${R}\" ${R}\"${W}Number 3${R}\" ${R}\"${W}Number 4${R}\"${EMC})"
	echo -e ""
	myVar=$(varSwitch options[@] "Number 2" "next")
	echo -e "${EMK}# Testing next var in array"${NONE}
	echo -e "${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${W}Number 2${R}\" ${R}\"${W}next${R}\"${B})"${NONE}
	echo -e "${EMW}The ${EMR}next ${EMW}value of ${EMB}\"${EMG}Number 2${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}

	# Testing wrap around
	myVar=$(varSwitch options[@] "Number 4" "next")
	echo -e "${EMK}# Testing next var in array with wrap around"${NONE}
	echo -e "${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${W}Number 4${R}\" ${R}\"${W}next${R}\"${B})"${NONE}
	echo -e "${EMW}The ${EMR}next ${EMW}value of ${EMB}\"${EMG}Number 4${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}

	# Testing previous var in array
	myVar=$(varSwitch options[@] "Number 3" "previous")
	echo -e "${EMK}# Testing previous var in array"${NONE}
	echo -e "${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${W}Number 3${R}\" ${R}\"${W}previous${R}\"${B})"${NONE}
	echo -e "${EMW}The ${EMR}previous ${EMW}value of ${EMB}\"${EMG}Number 3${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}

	# Testing wrap around
	myVar=$(varSwitch options[@] "Number 1" "previous")
	echo -e "${EMK}# Testing previous var in array with wrap around"${NONE}
	echo -e "${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${W}Number 1${R}\" ${R}\"${W}previous${R}\"${B})"${NONE}
	echo -e "${EMW}The ${EMR}previous ${EMW}value of ${EMB}\"${EMG}Number 1${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}

	# Testing ramdom var from array
	myVar=$(varSwitch options[@] "" "random")
	echo -e "${EMK}# Testing ramdom var from array"${NONE}
	echo -e "${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${R}\" ${R}\"${W}random${R}\"${B})"${NONE}
	echo -e "${EMW}A ${EMR}random ${EMW}value of the options ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}

	# Testing getting the first variable of the array
	myVar=$(varSwitch options[@] "Number 3" "first")
	echo -e "${EMK}# Testing getting the first variable of the array"${NONE}
	echo -e "${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${W}Number 3${R}\" ${R}\"${W}first${R}\"${B})"${NONE}
	echo -e "${EMW}The ${EMR}first ${EMW}value of ${EMB}\"${EMG}Number 3${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}

	# Testing getting the last variable of the array
	myVar=$(varSwitch options[@] "Number 3" "last")
	echo -e "${EMK}# Testing getting the last variable of the array"${NONE}
	echo -e "${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${W}Number 3${R}\" ${R}\"${W}last${R}\"${B})"${NONE}
	echo -e "${EMW}The ${EMR}last ${EMW}value of ${EMB}\"${EMG}Number 3${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}

	# Testing removing a variable of an array
	declare -a myArr=$(varSwitch options[@] "Number 2" "remove")
	echo -e "${EMK}# Testing removing a variable of an array"${NONE}
	echo -e "${M}declare ${W}-a ${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${W}Number 2${R}\" ${R}\"${W}remove${R}\"${B})"${NONE}
	echo -e "${EMW}The variable to be ${EMR}removed ${EMW}is ${EMB}\"${EMG}Number 2${EMB}\" ${W}new array ${EMC}\$myArr${EMK}="${NONE}${myArr[@]}
	echo -e ""${NONE}

	declare -a myArr=($(varSwitch options[@] "" "off"))
	echo -e "${EMK}# Testing removing all values of the array"${NONE}
	echo -e "${M}declare ${W}-a ${W}myVar${EMK}=${EMB}\$${EMC}(${B}varSwitch ${M}options${EMY}[${EMC}@${EMY}] ${R}\"${R}\" ${R}\"${W}off${R}\"${B})"${NONE}
	echo -e "${EMW}All values to be ${EMR}removed ${EMW}returns ${W}new array ${EMC}\$myArr${EMK}="${NONE}${myArr[@]}
	echo -e ""${NONE}

	options=(
		true
		false
	)

	echo -e "${EMW}options${EMK}=${EMC}(${EMB}true ${EMB}false${EMC})"
	echo -e ""

	# Testing the toggle switch
	myVar=$(varSwitch options[@] false "toggle")
	echo -e "${EMK}# Testing the toggle switch"${NONE}
	echo -e "${EMW}The variable to be ${EMR}toggled ${EMW}is ${EMB}\"${EMG}false${EMB}\" ${EMW}is now ${EMB}\"${EMC}$myVar${EMB}\""${NONE}

	myVar=$(varSwitch options[@] true "toggle")
	echo -e "${EMK}# Testing the toggle switch"${NONE}
	echo -e "${EMW}The variable to be ${EMR}toggled ${EMW}is ${EMB}\"${EMG}true${EMB}\" ${EMW}is now ${EMB}\"${EMC}$myVar${EMB}\""${NONE}
	echo -e ""${NONE}
    pause
	showMenu1
}

colorMenu1() {
	colors
    pause
	showColorMenu
}

colorMenu2() {
	colors.256
	pause
	showColorMenu
}

colorMenu3() {
	colors.codes
	pause
	showColorMenu
}

showMenu1() {
	clear
	local choice
	echo -e "${EMK}~~~~~~~~~~~~~~~~~~~~~"${NONE}
	echo -e "${EMB}  M A I N - M E N U  "${NONE}
	echo -e "${EMK}~~~~~~~~~~~~~~~~~~~~~"${NONE}
	echo -e "${EMC}[${EMG}1${EMC}] ${NONE}Show varSwitch examples"
	echo -e "${EMC}[${EMG}2${EMC}] ${NONE}Show color samples"
	echo -e "${EMC}[${EMG}E${EMC}] ${NONE}Exit"
	echo -e "${EMW}Enter choice ${EMC}[${EMG}1 ${EMK}- ${EMG}2 ${NONE}or ${R}[${EMR}E${R}]${EMC}]"${NONE} && read choice
	
	while true
	do
		case ${choice^^} in
			1) menu1Opt1;;
			2) showColorMenu;;
			"H") showHelpMenu;;
			"E") exit 0;;
			*)
				echo -e "${EMR}Invalid option...${NONE}" && sleep 1
				showMenu1
				;;
		esac
	done
}

showColorMenu() {
	clear
	local choice
	echo -e "${EMK}~~~~~~~~~~~~~~~~~~~~~"${NONE}
	echo -e "${EMB} C O L O R - M E N U "${NONE}
	echo -e "${EMK}~~~~~~~~~~~~~~~~~~~~~"${NONE}
	echo -e "${EMC}[${EMG}1${EMC}] ${NONE}Show 16 color samples"${NONE}
	echo -e "${EMC}[${EMG}2${EMC}] ${NONE}Show 256 color samples"
	echo -e "${EMC}[${EMG}3${EMC}] ${NONE}Show color codes"
	echo -e "${EMC}[${EMG}E${EMC}] ${NONE}Exit to Main"
	echo -e "${EMW}Enter choice ${EMC}[${EMG}1 ${EMK}- ${EMG}3 ${NONE}or ${R}[${EMR}E${R}]${EMC}]"${NONE} && read choice

	while true
	do
		case ${choice^^} in
			1) colorMenu1;;
			2) colorMenu2;;
			3) colorMenu3;;
			"E") showMenu1;;
			*)
				echo -e "${EMR}Invalid option...${NONE}" && sleep 1
				showColorMenu
				;;
		esac
	done
}

showHelpMenu(){
	return
}

  #== Main part ==#
  #===============#
{
    scriptstart ;

    #== start your program here ==#
	infotitle "Executing Test examples"
	showMenu1

    #infotitle "Running simple cmd"
    #exec_cmd "ls -lrt $* ;"

    #infotitle "Running cmd in parrallel (bg jobs)"
    #exec_cmd "sleep 10 ;" &
    #exec_cmd "cat somequotes.txt ;" &
    #exec_cmd "echo Another sleep cmd; sleep 9 ;" &
    #exec_cmd "ls -lrt filenotexist ;" &
    #sleep 1
    #jobs -l 2>&1 | fecho CAT "jobs -l"
    #wait_cmd 60

    #infotitle "Generating a wait_cmd timeout"
    #exec_cmd "sleep 8 ;" &
    #wait_cmd 6

    ipcf_save_rc >/dev/null

    #== end   your program here ==#
    scriptfinish;
} 2>&1 | tee ${fileLog}
exit $rc