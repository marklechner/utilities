#!/bin/sh
# Quick and dirty way to generate pseudo-random pw with a few rules applied

PASS=$(/usr/bin/openssl rand -base64 18)

check_pass () {
    local pass=$1
    # Check if password contains uppercase
    printf '%s' "$pass" | grep -q '[A-Z]' || return 1
    # Check if password contains lowercase
    printf '%s' "$pass" | grep -q '[a-z]' || return 1
    # Check if password contains numbers
    printf '%s' "$pass" | grep -q '[0-9]' || return 1
    # Check if password contains special characters
    printf '%s' "$pass" | grep -q '[^a-zA-Z0-9 \t]' || return 1
    return 0
}

until check_pass "$PASS" 
do
    PASS=$(/usr/bin/openssl rand -base64 18)
done
echo $PASS
