## Regular Expression

## Regex pattern 
* `.` For missing letter (ex: c.t => display cat)
* `^` <u>Caret</u> : sarting the line with (ex: ^ERROR), the opposite (end of line) : `$` (ex: log$). Or : "all except..."
* `*`: One or more time the character ahead is repeated (ex: do*g => to display doooog)
* `\1`: backreference : a copy of the precedent character ((a)/1 = we search for 'aa')
* `+` : If we are sure there are 2+ missing characters (ex: do+g), meaning : one or multiple character defined can appear
* `?` : After a potential character (ex: colou?r => to get color and colour)
* `|` : <u>Pipe</u> : to match two string (ex: red|white)
* `[]`: A gathering of characters, meaning : "one character among them"
* `{n}`: n = Minimum number of time we need to encounter the charcater define ahead. `{3,}` = three time of more

*Examples : operators*
```bash
if [[ "$url" =~ ^https?://([^/]+) ]]; 
# =~ searching into...
# ^ (1) starting with https
# ? can have a character here
# () define a capture group
# [] group of character to check
# ^ (2) all characters except /
# + potentially multiple /

^(abc|def)[0-9]+$
# Starting by abc or def
# Ending with one or more numeric 

^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
# First capture group containing one or more (+) characters which can be a to z, A to Z, 0 to 9, a point, an underscore, %, + or -
# Then a @
# Followed by one or more (+) a to z, A to Z, 0 to 9, a point or -
# Then a point (escaped by /)
# Ending by minimum (,) 2 str typed characters

^\+?[1-9][0-9]{7,14}$
# Start with an optionnal +
# Then, one digit included in 1 to 9 
# Ending with 7 to 14 digits

^(\d{1,3}\.){3}\d{1,3}$
# First capture group : start with 1 to 3 digits, then a point, this is repeated exactly three times
# Ending with 1 to 3 digits

```

### Group capture with parenthesis
Create numbered capture groups, isolating subsets of a matched pattern
```bash
text="abcdef"
if [[ $text =~ (abc)(def) ]]; then # Meaning it captures the 'def' part of the text
    echo "Full match : ${BASH_REMATCH[0]}" # Display "abcdef"
    echo "Match of group 1 : ${BASH_REMATCH[1]}" # Contains "abc" = group 1
    echo "Match of group 2 : ${BASH_REMATCH[2]}" # Contains "def"
fi
```

Use backreferences with groups
```bash
(a)(b)\1\2
# Step 1 (a): match 'a' and remember it as \1
# Step 2 (b): match 'b' and remember it as \2
# Step 3 \1: paste the copied first capture group
# Step 4 \2: paste the copied second capture group
```

### Using grep command
```bash
grep --color 'expression' file.txt # Color the findings
grep -E # Grep Extended, including all meta-characters
-i # Case insensitive
```
