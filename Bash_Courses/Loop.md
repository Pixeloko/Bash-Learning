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