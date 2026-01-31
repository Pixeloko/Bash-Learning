### Assign command to variable 
```bash
LINUX_COMMAND=$(uname)
echo 'Name of the kernel : #{LINUX_COMMAND}'
```
Or use command into echo
```bash
echo "Hey, I'm in $(pwd)"
```

### Input 
`read -p "..." variable` with -p to show prompt and get the input together, then stock the response in the variable

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
echo "${name:-1}" # Cut the last letter
```