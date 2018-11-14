clear

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/bashrc_functions.sh"

if [ -z "$PS1" ]; then
  return
fi

PROMPT_COMMAND=bash_prompt_command
bash_prompt

options=(
	"Number 1"
	"Number 2"
	"Number 3"
	"Number 4"
)

# Test next var in array
myVar=$(varSwitch options[@] "Number 2" "next")
echo -e "${EMW}The ${EMR}next ${EMW}value of ${EMB}\"${EMG}Number 2${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}

# Test wrap around
myVar=$(varSwitch options[@] "Number 4" "next")
echo -e "${EMW}The ${EMR}next ${EMW}value of ${EMB}\"${EMG}Number 4${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}

# Test next var in array
myVar=$(varSwitch options[@] "Number 3" "previous")
echo -e "${EMW}The ${EMR}previous ${EMW}value of ${EMB}\"${EMG}Number 3${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}

# Test wrap around
#myVar=$(varSwitch options[@] "Number 1" "next")
#echo "The next value of \"Number 1\" is \"$myVar\""

# Test ramdom var from array
myVar=$(varSwitch options[@] "" "random")
echo -e "${EMW}A ${EMR}rendom ${EMW}value of the options ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}

# Test getting the first variable of the array
myVar=$(varSwitch options[@] "Number 3" "first")
echo -e "${EMW}The ${EMR}first ${EMW}value of ${EMB}\"${EMG}Number 3${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}

# Test getting the last variable of the array
myVar=$(varSwitch options[@] "Number 3" "last")
echo -e "${EMW}The ${EMR}last ${EMW}value of ${EMB}\"${EMG}Number 3${EMB}\" ${EMW}is ${EMB}\"${EMC}$myVar${EMB}\""${NONE}

# Testing removing a variable of an array
declare -a myArr=$(varSwitch options[@] "Number 2" "remove")
echo -e "${EMW}The variable to be ${EMR}removed ${EMW}is ${EMB}\"${EMG}Number 2${EMB}\""${NONE}
echo ${myArr[@]}

#options=($(varSwitch options[@] "Number 3" "off"))
#echo "Clearing all values returns:"

#index=0
#while [ "$index" -lt "${#options[@]}" ]; do
#    echo ${options[$index]}
#    let "index++"
#done

colors
colors.256
colors.codes