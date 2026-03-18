Definition : "A file descriptor is a unique identifier, typically a non-negative integer, that the operating system assigns to an open file or other input/output resource, allowing programs to interact with those resources."

# File descriptor manipulations
Modes
* `fd<file` Open and read, associate file to fd
* `fd>file` Open and write in empty file
* `fd>>file` Open and append to file

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