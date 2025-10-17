#!/bin/bash

read -p "Enter username to run VS Code as: " USERNAME

if ! id "$USERNAME" &>/dev/null; then
    sudo useradd -m "$USERNAME"
fi

sudo -u "$USERNAME" code