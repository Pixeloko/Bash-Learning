## Regular Expression

## Regex pattern 
* `.` For missing letter (ex: c.t => display cat)
* `^` <u>Caret</u> : sarting the line with (ex: ^ERROR), the opposite (end of line) : `$` (ex: log$). Or : "all except..." ([^\s]+ matches all except one or repeated white spaces)
* `*`: One or more time the character ahead is repeated (ex: do*g => to match doooog or dog, \d\* to find 2 digits)
* `\1`: backreference : a copy of the precedent character ((a)/1 = we search for 'aa')
* `+` : If we are sure there are 2+ missing characters (ex: do+g), meaning : one or multiple character defined can appear
* `?` : After a potential character (ex: colou?r => to get color and colour, <h1>(.\*?)<\/h1> to capture title and register it in group 1 ). ≠ With . because not greedy 
* `(?!)` : <u>Lookarounds (need parenthesis)</u>, not followed by ... (ex : \w(?!\s) : a word not followed by a white space)
* `(?=)` : Followed by ... (<u> Positive lookahead</u>) (ex: matching line containing pwd : ^(?=.\*pwd).\*?$)
* `|` : <u>Pipe</u> : to match two string (ex: red|white)
* `[]`: A gathering of characters, meaning : "one character among them"
* `{n}`: n = Minimum number of time we need to encounter the character define ahead. `{3,}` = two time of more, `{1,3}` = one to 2 
* `\A`: Match the very start ≠ `\Z`

## Type of characters
* `\w`: match a letter
* `\d`: match a digit
* `\s`: match a space

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

### Specificities
#### Difference between .* and .*? Greedy and lazy approaches
* `.*` : Match any character (.) and all coming after (*), without consideration for what we need to match. Example :
```bash
echo 'eeeAiiZuuuuAoooZeeee' | grep -E 'A.*Z' # Match AAiiZuuuuAoooZ
# 1. Match A, and all coming after, up to the final e
# 2. But the last character to match is Z, so the engine search for the last Z to display the final match
```
* `.*?` : Match the minimal repetition of a any character (non-greedy)
```bash
echo 'eeeAiiZuuuuAoooZeeee' | grep -E 'A.*?Z' # Match AiiZ
echo 'eeeAiiZuuuuAoooZeeee' | grep -o 'A.*?Z' # Match AiiZ AND AoooZ
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

Name a group by adding a `?<...>` inside the capturing parenthesis
```bash
(?<groupname>.*?) # The group is named groupname and the regex is .*?
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

### Using regex in Javascript
To write regex in JS console, write is inside two `/here/`, after the second forward slash, add a flag.
* `gi` for global (g) (find all matches) and insensitive (i)

### Additional ressources
* [To test regex](https://regex101.com)
* [Useful video](https://youtu.be/saABx34CsBE?si=A3b9ewQYNcnqHf6j)