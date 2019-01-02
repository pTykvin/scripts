#!/bin/bash
[[ -z $1 ]] && echo "Usage $0 <ssh-crypt>" || openssl aes-256-cbc -d -in $1 -out - -pbkdf2 | tar -xzvf - -C ~/.ssh
