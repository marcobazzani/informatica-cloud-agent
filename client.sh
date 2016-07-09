#!/bin/bash


while read FOO; do
        echo $FOO >&3
        if [[ $FOO =~ `printf ".*\x00\x1c.*"` ]]; then
                break
        fi
done
