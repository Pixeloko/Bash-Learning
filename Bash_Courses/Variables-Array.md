# Variables
### Assign command to variable 
```bash
LINUX_COMMAND=$(uname)
echo 'Name of the kernel : #{LINUX_COMMAND}'
unset LINUX_COMMAND # to unassign variable
```
Or use command into echo
```bash
echo "Hey, I'm in $(pwd)"
```

### Input 
`read -p "..." variable` with -p to show prompt and get the input together, then stock the response in the variable
`read -r variable'` read and assign

execute the bash-script with pre-set inputs
```bash
# write in the bash-script file
echo "${0}" 
echo "${1}" 
echo "${2}" 
# execute the file 
./bash-script hello world # 0=name of the file 1=hello 2=world
```
`${#}` For the number of arguments passed when executing the bash script

`echo $?` to see exit code 
* 0=success
* 1=fail
* 126=command not executable
* 127=command not found
type it after running a script or executing a command


### Manipulation
substitution
```bash
old = "oldstring"
echo "The new string has a capital letter : ${old/o/O}
```

slicing
```bash
name = "Bob"
echo "${name:0:2}" # Take letter from position 0 to 2
echo "${name:-1}" # Cut the last letter (display Bo)
echo "${name:(-1)}" # Slice from right (display b)
```

calculation
`((operation))`
`$((operation))` To re-use a variable

# Array
`ARRAY=()` Initiate empty array
`ARRAY+=(1|"item")` Append into array
`${#ARRAY[@]}` Get number of elements in ARRAY
`${ARRAY[@]}` List of all element in array
`echo ${ARRAY[*]}` display all items in array 
`${#ARRAY[1]}` Access a specifi position
`{1..5}` int range