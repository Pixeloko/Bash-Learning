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
* `echo "alias name='./script arg1 arg2'" >> ~/.bashrc ; source ~/.bashrc` make it permanent, source to reload
* `nohup ./[script] [redirections] & rm nohup.out` run even if terminal closed, delete default filee creation
* `xargs` transforms an input into argument 
Exemple : 
```bash
docker ps -q | xargs docker inspect 
```
* `tr 'search' 'subtitution'` means translate
* `eval` execute a command stocked in a char, interpreting pipe etc
* `dpkg -l` list packages

## Distinction printf and print
printf is more formatted and controls decimals

