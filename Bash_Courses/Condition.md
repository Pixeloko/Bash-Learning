## Condition
### Syntax
*Syntax for `if` condition (will return True or Fase)*

```bash
# With elif
if [[ condition ]]; then
    echo "string"
elif [[ new condition ]]; then
    echo "string"
fi

# With else
if [[ condition ]]
then
    command
    command2
else
    command3
fi
```

### Examples of conditions
```bash
[[ -z STRING ]] # Empty string
[[ -n STRING ]] # Not empty string
[[ STRING1 ≠ STRING2 ]] # Not empty string
[[ STRING1 == STRING2 ]] 
[[ "${VARIABLE1}" == "${VARIABLE2}" ]] # test variables
[[ NUM -eq NUM ]] # Equal, for numerics
[[ "${VARIABLE1}" -eq "${VARIABLE2}" ]] # test variables 
[[ NUM -ne NUM ]] # Not equal
[[ NUM -lt NUM ]] # Less than (≠gt)
[[ NUM -le NUM ]] # Less than or equal (≠ge)
(( NUM < NUM )) # Numeric condition
# And same, for greater, replace with a 'g'
[[ "string" =~ pattern ]] # Check if a string match a regexp pattern
[[ -e file ]] # verify the file exists (use with if)
```

*to test multiple conditions use `&&` and `||` between each [[single condition]]*