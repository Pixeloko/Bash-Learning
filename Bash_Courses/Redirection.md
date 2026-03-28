Definition : "A file descriptor is a unique identifier, typically a non-negative integer, that the operating system assigns to an open file or other input/output resource, allowing programs to interact with those resources."

# File descriptor manipulations
Modes
* `fd<file` Open and read, associate file to fd
* `fd>file` Open and write in empty file
* `fd>>file` Open and append to file
Other operators
```bash
1> # Or 0> or 2> sends strems to a file
&> # stdout & stderr to a file
&>> # stdout & stdeer to a file (appending)
command < input_file # attribute the file content to the command 
```
called here document/heredoc redirects multiple lines to a command 
```bash
command << EOF
    line1
    line2
    line3
EOF # EOF to mark beginning and end of lines
```
⚠️ `cd` or `echo` waits only argument, no standard entries (will not work)

Open and read 
```bash
exec 3<file # open and read on fd3
while read -u 3 line; # -u 3 read on fd3
    do echo "$line"; 
    read -p "Press any key" -n 1; # -n wait for a single inuput (no Enter)
    done; 
exec 3>&- # closing the fd3
```

Duplicate (destination)
`exec 2>&1`
Copy the destination of stdout to stderr (output and erros diplayed in terminal)
syntax : target>&source

`echo Done` output back to original stdout