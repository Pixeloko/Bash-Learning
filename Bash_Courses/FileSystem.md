## Operators to check on files and diretories
### Display a boolean

`-d` is it a directory (See [Condition](Condition.md#examples-of-conditions))
`-e` is it a file + `-f`is it regular, `-r`is it readable
`! -e` there is no such file
`-s` is file's size < 0 ?
`-w` is it writable
`-x` is it executable
*see more file type tests [here](https://ss64.com/bash/test.html)*

*test in terminal*
```bash
test -e file
echo $?
```

Substitution in a text file
```bash
sed 's/find/substitution' file # reimplace all 'find' by 'substitute' and display the result, does not save
```
⚠️ DO NOT DO THAT : `sed 's/find/substitution' file # ` 
Because shell's order of execution goes : 
1. Look at redirection `> file` , it empty the file to save the incoming output of command
2. Look at the command `sed`
Solution
```bash
sed 's/find/substitution' file > tmp && mv tmp file # rename (and overwrite) to 'file' at the end
```

*attribute file content to a command*
`command < file` # usually using sort, wc -l see more in [redirection](/Bash_Courses/Redirection.md)