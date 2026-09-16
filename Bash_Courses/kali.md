# Lexicon
- ==Option== modifies the command
- ==Argument== passes data to the command
- ==Daemon== process executing itself in background

## Shortcuts for kali linux VM (on mac)
* anti-backlash : option + 8 
* pipeline : option + 6
* tilde ~: option + 2

## Kali commands
* `sudo dhcpcd eth0` ask for IP to connect to Internet
* `sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'` DNS resolver, use Google
* `apt list --installed | grep <tool>`
* `wget` <url/file>
* `alias <name>='./script arg1 arg2'` will be temporary
* `echo "alias name='./script arg1 arg2'" >> ~/.bashrc ; source ~/.bashrc` make it permanent, source to reload (read + execute)
* `nohup ./[script] [redirections] & rm nohup.out` run even if terminal closed, delete default filee creation
* `xargs` transforms an input into argument 
Exemple : 
```bash
docker ps -q | xargs docker inspect 
```
* `tr 'search' 'subtitution'` means translate
* `eval` execute a command stocked in a char, interpreting pipe etc
* `dpkg -l` list packages
* `sudo vi` > `:!bash` launch a bash shell with root right (the user who launch vi) 
* `passwd` change the password of the actual 

## Execute / Clean
`timeout 3 <command>`
`trap <action> <condition>` execute something for one condition, example : `trap 'echo "You pressed Ctrl+C, Exiting..."; exit 130' SIGINT`
|CONDITIONS|DESCRIPTION|
|---|----|
|EXIT||
|SIGINT|when hit Ctrl+C|
|SIGTERM|hit kill command|
|SIGHUP|terminal closes or process disconnected|
|ERR|command receives a non-zero exit status|
|DEBUG|<action> is executed before every command|
|RETURN|<action> executed each time a function or script is executed|


## Distinction printf and print
printf is more formatted and controls decimals

# Remote access
## With SSH
`ssh username@host`

# Security
```bash
gpg --generate-key # will store in ~/<user>/.gnupg
gpg --encrypt file
gpg --encrypt --passphrase "<passphrase>" <file>
gpg --decrypt file
gpg --sign file
gpg -k # list key
gpg --output file.pgp --armor --export-secret-key <mail-or-id> # export private key (associated to id/mail) to a file, in ASCII (readable)
ssh-keygen -t rsa -C "" # -t type and -C empty not to inform about our computer's hostname at the end of the key (default)
```
   
