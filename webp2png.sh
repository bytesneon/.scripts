#!/bin/bash

#Use convert to convert all .webpg in the current directory to .png
for img in *.webp; do
    if [ -f "$img" ]; then
        echo "Converting $img to png"
        convert "$img" "${img%.webp}.png"
    fi
done

#Remove all .webp files on request y/n
read -p "Do you want to remove all .webp files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm *.webp
fi
