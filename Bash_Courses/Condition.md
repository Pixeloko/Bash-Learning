## Condition
### Syntax
*Syntax for `if` condition (will return True or Fase)*

```bash
if [[ condition ]]; then
    echo "string"
elif [[ new condition ]]; then
    echo "string"
fi
```

### Examples of conditions
```bash
[[ -z STRING ]] # Empty string
[[ -n STRING ]] # Not empty string
[[ NUM -eq NUM ]] # Equal, for numerics
[[ NUM -ne NUM ]] # Not equal
[[ NUM -lt NUM ]] # Les than 
[[ NUM -le NUM ]] # Les than or equal
(( NUM < NUM )) # Numeric condition
# And same, for greater, replace with a 'g'
[[ "string" =~ pattern ]] # Check if a string match a regexp pattern
```