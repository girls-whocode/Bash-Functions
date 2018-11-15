clear

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/bashrc_functions.sh"

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

#options=($(varSwitch options[@] "Number 3" "off"))
#echo "Clearing all values returns:"

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

