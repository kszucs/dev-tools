#!/usr/bin/env bash

# Run this script as sudo. The machine should be configured to only permit SSH
# public key login

set -ex

# script idempotence
userdel ursa
rm -rf /home/ursa

adduser --disabled-password --gecos "" ursa
usermod -aG sudo ursa

echo "ursa:ursa" | chpasswd

SSH_DIR=/home/ursa/.ssh
mkdir -p $SSH_DIR

function add_ssh_keys() {
    wget https://github.com/$1.keys -O ->> $SSH_DIR/authorized_keys
}

rm -f $SSH_DIR/authorized_keys

add_ssh_keys bkietz
add_ssh_keys fsaintjacques
add_ssh_keys wesm
add_ssh_keys kszucs
add_ssh_keys jorisvandenbossche
add_ssh_keys pitrou
add_ssh_keys nealrichardson

chown -R ursa /home/ursa
