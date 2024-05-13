#!/bin/bash

# Set a variable to track whether the ARK build failed
FAILED_ARK_BUILD=0

# Temporarily move Xbox and Wii files out of the ARK path to reduce final ARK size
#echo
#echo "Temporarily moving Xbox and Wii files out of the ark path to reduce final ARK size"
#find "$PWD/_temp/_ark" \( -name "*.bik" -o -name "*.milo_wii" -o -name "*.png_wii" -o -name "*.bmp_wii" \) -exec mv -t "$PWD/_ark" {} +
#find "$PWD/_ark" \( -name "*.milo_xbox" -o -name "*.png_xbox" -o -name "*.bmp_xbox" \) -exec mv -t "$PWD/_temp/_ark" {} +

# Building PS3 ARK
echo
echo "Building PS3 ARK"
"$PWD/dependencies/arkhelper" dir2ark "$PWD/_ark" "$PWD/_build/ps3/USRDIR/gen" -n "patch_ps3" -e -v 5 -s 4073741823 >/dev/null 2>&1
if [ $? -ne 0 ]; then
    FAILED_ARK_BUILD=1
fi

# Moving back Xbox files
#echo
#echo "Moving back Xbox files"
#find "$PWD/_temp/_ark" \( -name "*.bik" -o -name "*.milo_wii" -o -name "*.png_wii" -o -name "*.bmp_wii" \) -exec mv -t "$PWD/_ark" {} +
#find "$PWD/_ark" \( -name "*.milo_xbox" -o -name "*.png_xbox" -o -name "*.bmp_xbox" \) -exec mv -t "$PWD/_temp/_ark" {} +

# Clean up temporary directory
rm -rf "$PWD/_temp"

# Check if the ARK build failed and provide appropriate message
echo
if [ "$FAILED_ARK_BUILD" -ne 1 ]; then
    echo "Successfully built Green Day Rock Band Ultimate ARK. You may find the files needed to place on your PS3 in /_build/PS3/"
else
    echo "Error building ARK. Check your modifications or run _git_reset.bat to rebase your repo."
fi

echo
read -p "Press Enter to continue..."
