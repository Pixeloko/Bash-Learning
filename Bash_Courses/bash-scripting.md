# Scripting Commands
## Debugging
`bash -n script.sh` Without executing, check for syntaxe, raise error
`bash -x script.sh`Execute with verbose on
slice portion of the script to debug
```bash
#!/bin/bash
action # not to be debug
set -x # debug begin
--snip-- # debugged code
set +x # debug end
action # not to be debug
```

## Operators
`[command] &` send the command to the background
`([command1];[command2])` () group commands as one ; wait for the first to finish after the second gets executed (no matter if True or False)