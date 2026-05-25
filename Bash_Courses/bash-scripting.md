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
* `[command] &` send the command to the background
* `([command1];[command2])` () group commands as one ; wait for the first to finish after the second gets executed (no matter if True or False)
* `command1 && command2` executes only if first succeeded 
* `cmd1 || cmd2` executes if the first failed

# Tools
## Send email in the terminal with sendemail
```bash
brew install sendemail
sendemail -f "sender-email" -t "reciever" -u "object" -m "message" -s "smtp.gmail.com:587" -xu "send-email" -xp "key" -o tls=yes
```
to generate the key (Gmail) : Google Account > Activate double authentification > App passwords

## Nuclei
stored template at ~/.local/nuclei-templates
```bash
nuclei -u <BaseUrl> -t <path-to-template> # first run will install official templates if not downloaded yet
nuclei -tags <tag>,<tag> -u ip # run specific template
```
output syntax : [template][protocol][severity] url [extractor]

## Fuff / Fuzzing
```bash
fuff - -w wordlist.txt -u <http://...>/FUZZ # -c color, FUZZ will be replaced by wordlist entry
wfuzz -sc <http-code> <wordlist.txt> <http://ip:port> # recieve only for this code
```