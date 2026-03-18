### For loop
```bash
for i in directory/file; do
    echo "$i"
done
```

### Listing
`{A,B}` same as A B
`{A,B}.js` A.js and B.js
`ab{c,d,e}f` for enumeration abcf acdf abef (ex: mkdir /usr/local/src/bash/{old,new,dist,bugs})
`{1..5}` for range 1 2 3 4 5 (two dots for loop iteration)

### Looping over arguments with $@
`$@`List of argument passed when executing the script, example to display
```bash
echo "number of arguments : $#"
echo "listed arguments : "
count=1
for arg in "$@"; do
    echo "Arg $count : $arg"
    count=$((count+1))
done
```