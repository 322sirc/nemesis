#!/bin/bash

# Check if list.txt exists
if [[ ! -f "list.arch.xfce4" ]]; then
    echo "Error: list.txt not found!"
    exit 1
fi

# Read each line from list.txt and install the package
while IFS= read -r package; do
    # Skip empty lines and comments
    [[ -z "$package" || "$package" == \#* ]] && continue
    echo "Installing: $package"
    sudo pacman -S --noconfirm --needed "$package"
done < "list.arch.xfce4"
