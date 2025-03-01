#!/bin/bash

# Set a variable to track whether the ARK build failed
FAILED_ARK_BUILD=0

# Set the path to wit and arkhelper
WIT_PATH="$PWD/dependencies/wit/wit"
ARKHELPER_PATH="$PWD/dependencies/arkhelper"

# Extract ISO using wit
"$WIT_PATH" extract "$PWD/iso" "$PWD/_build/wii"

# Copy patched main.dol and setup.txt
cp -rf "$PWD/dependencies/patch/main.dol" "$PWD/_build/wii/sys"
cp -rf "$PWD/dependencies/patch/setup.txt" "$PWD/_build/wii"

# Copy main_wii.hdr to appropriate directory in case of old tbrbu build
cp "$PWD/_build/wii_rebuild_files/main_wii.hdr" "$PWD/_build/wii/files/gen"

# Remove main_wii_10.ark to save space
rm "$PWD/_build/wii/files/gen/main_wii_10.ark" 2> /dev/null

# Temporarily move Xbox and Wii files out of the ARK path to reduce final ARK size
#echo
#echo "Temporarily moving Xbox and PS3 files out of the ark path to reduce final ARK size"
#find "$PWD/_ark" \( -name "*.milo_xbox" -o -name "*.png_xbox" -o -name "*.bmp_xbox" -o -name "*.milo_ps3" -o -name "*.png_ps3" -o -name "*.bmp_ps3" \) -exec mv -t "$PWD/_temp/_ark" {} +

# Create patched files using arkhelper
"$ARKHELPER_PATH" dir2ark "$PWD/_ark" "$PWD/_build/wii/files/gen" -n "patch_wii" -e -v 5 -s 4073741823 >/dev/null 2>&1
if [ $? -ne 0 ]; then
    FAILED_ARK_BUILD=1
fi

# Moving back Xbox files
#echo
#echo "Moving back Xbox files"
#find "$PWD/_temp/_ark" \( -name "*.milo_xbox" -o -name "*.png_xbox" -o -name "*.bmp_xbox" -o -name "*.milo_ps3" -o -name "*.png_ps3" -o -name "*.bmp_ps3" \) -exec mv -t "$PWD/_ark" {} + 2> /dev/null

# Extract ISO using wit
"$WIT_PATH" copy "$PWD/_build/wii" "$PWD/iso/GDRB Ultimate.wbfs"

# Check if the ARK build failed and provide appropriate message
echo
if [ "$FAILED_ARK_BUILD" -ne 1 ]; then
    echo "Successfully built Green Day Rock Band Ultimate ARK files. A wbfs file has been generate in the iso folder"
else
    echo "Error building ARK. Download the repo again or some dta file is bad p.s turn echo on to see what arkhelper says"
fi

# Pause to keep terminal open
read -p "Press Enter to continue..."
