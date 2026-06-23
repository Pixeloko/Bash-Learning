# Variables
## Environment variables
```bash
$PATH # binaries locations acccessible by all programs
```

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

Place holder 
```bash
printf "192.10.10.%d\n" {1..254} # %d will be replaced by what's inside braces
```

use ${} instead of "${}" when :
* new assignation `old=${new}`
* in condition `[[]]` 


### Input 
`read -p '...' variable` with -p to show prompt and get the input together, then stock the response in the variable
`read -r variable'` read and assign

execute the bash-script with pre-set inputs
```bash
# write in the bash-script file
echo "${0}" 
echo "${1}" 
echo "${2}" 
# execute the file 
./bash-script hello world # 0=name of the file 1=hello 2=world
dir_search="${1:-<default-value>}" # argument if passed or default-value
```
`${#}` For the number of arguments passed when executing the bash script

`echo $?` to see exit code (ex : output of test) of the last command executed
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
echo "${name:-1}" # Print the last letter
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
`$(seq 1 10)` range int list

# Characters and URL encoding
|Characters|URL Encoding|
|:---:|:---:|
|space|%20|
|/|%2F|
|?|%3F|
|&|%26|
|=|%3D|
|:|%3A|
|;|%3B|
|#|%23|
|+|%2B|
|,|%2C|

# Placeholders
* `%s`string
* `%d`integer
* `%f`float
* `%b`binary
* `%x`hexa
usage 
```bash
printf("Text with %placeholder", $variable)
```

# Hexadecimals
```bash
echo $((16#<hex>)) # convert hexadecimals (base16) into decimals
```