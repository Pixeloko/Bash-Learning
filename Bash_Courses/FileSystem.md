# Filesystem

| / | description |
|------|---------------------------------|
|/var | non static files (app logfiles) |
|/etc  | config files and info (pass)    |
|/bin /sbin  | binary utilities and system binaries|
|/dev  | access to device files (external drive, disk manipulation)|
|/proc | processes PID|
|/usr  | user binaries, man              |
|/opt  | directory for software applications|
|/lib /lib32 /lib64  | shared librairies containing function used by multiple programms|

## /sys/
* find network interfaces in `/sys/class/net` do `ls -l` to see if it is physical interface or `/sys/devices/virtual/net`
* MAC address : `/sys/class/net/<interface>/address`
* `/sys/class/dmi/id` Desktop Management Interface details about pc components (bios, chassis, board game)

## /etc
* default settings for new user with adduser located in `/etc/adduser.conf` or/and `/etc/default/useradd`
* `/etc/os-release`
* in `etc/passwd` : account:psswd:UID:GID:comment:homedirectory:defaultshell
* `/etc/resolv.conf` find DNS server config (nameserver)
* `/etc/cron.allow` users registered able to create scheduled tasks, same for /etc/at.allow and at.deny

Configuration File in servers

|Server types|File localization|
|------------|-----------------|
| Web servers | /etc/httpd/httpd.conf <br> /etc/httpd/conf/httpd.conf <br> /etc/apache2/apache2.conf <br> /etc/lighttpd/lighttpd.conf <br> /etc/nginx/nginx.conf |
| File-sharing/transfer | /etc/vsftpd/vsftpd.conf <br> /etc/protftpd.conf <br> /usr/local/etc/proftpd.conf <br> /etc/samba/smb.conf|
|Databases | /etc/mysql/my.cnf <br> /etc/my.cnf <br> /etc/redis/redis.conf <br> /etc/mongo.conf <br> /etc/cassandra|
| DNS | /etc/bind/named.conf <br> /etc/dnsmasq.conf|
|Mail| etc/postfix/main.cf <br> /etc/mail/sendmail.cf <br> /etc/dovecot/dovecot.conf|
|VPN server | /etc/openvpn <br> /etc/ipsec.conf|

## /proc
|path|contains|
|---|---|
|/proc/<pid>/cmdline|command to start the process|
|/proc/<pid>/cwd|working directory of the process|
|/proc/<pid>/environ|environment variables of the process|
|/proc/<pid>/exe|binary that start the process|
|/proc/<pid>/task|subdirectories for each thread started by the process|
|/proc/<pid>/status||
|/proc/<pid>/fd|file descriptors, describes open files|
|/proc/net/route|gateway of interfaces|
|/proc/net/tcp|socket table|
|/proc/partitions|storage info or run `df -h -T`|

*/proc/<path> for kernel settings ≠ /proc/pid/<path> for one specific process*

## /var
* `/var/log` applications logs
* `/var/spool/cron/crontab/<user>` cron config
* `/var/cron*`system cron files
* `/var/spool/cron/atjobs` find jobs created with at. Also 

## Operators to check on files and diretories
### Display a boolean

`-d` is it a directory (See [Condition](Condition.md#examples-of-conditions))
`-e` is it a file + `-f`is it regular, `-r`is it readable
`! -e` there is no such file
`-s` is file's size < 0 ?
`-w` is it writable
`-x` is it executable
*see more file type tests [here](https://ss64.com/bash/test.html)*

*test in terminal*
```bash
test -e file
echo $?
```

Substitution in a text file
```bash
sed 's/find/substitution' file # reimplace all 'find' by 'substitute' and display the result, does not save
```
⚠️ DO NOT DO THAT : `sed 's/find/substitution' file # ` 
Because shell's order of execution goes : 
1. Look at redirection `> file` , it empty the file to save the incoming output of command
2. Look at the command `sed`
Solution
```bash
sed 's/find/substitution' file > tmp && mv tmp file # rename (and overwrite) to 'file' at the end
```

*attribute file content to a command*
`command < file` # usually using sort, wc -l see more in [redirection](/Bash_Courses/Redirection.md)