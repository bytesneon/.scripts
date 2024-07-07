#!/bin/bash
# Description: Takes a screenshot with Flameshot, uploads it to Gyazo, and opens the link in the browser.

# Flameshot command to take a screenshot and save it to a temporary file
tempfile=$(mktemp /tmp/screenshot.XXXXXX.png)
flameshot gui -r > "$tempfile"

# URL for Gyazo upload
url=https://upload.gyazo.com/upload.cgi

# Check if the temporary file was created and is not empty
if [ ! -s "$tempfile" ]; then
    echo "Screenshot failed or was cancelled."
    rm -f "$tempfile"
    exit 1
fi

# Read image file for upload
file="$tempfile"
bytes=$(wc -c < "$file")
if [ $bytes -gt 10485760 ]; then
    echo "File is too large"
    rm -f "$tempfile"
    exit 1
fi

echo "Uploading $file ($bytes bytes)..."

# Upload image
response=$(curl -s -F "imagedata=@$file" $url)

# Cleanup: remove the temporary file
rm -f "$tempfile"

# Open the response link in the default browser
if [ -n "$response" ]; then
    xdg-open "$response"
else
    echo "Failed to upload the image."
fi
