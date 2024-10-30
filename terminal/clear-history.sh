#!/bin/bash

echo "This script needs to be run with source command."

# One-liner to clear the history of the current terminal session
cat /dev/null > ~/.bash_history && history -c && exit