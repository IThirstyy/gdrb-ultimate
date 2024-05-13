#!/bin/bash

# Set the path to wit and arkhelper
WIT_PATH="$PWD/dependencies/wit/wit"
ARKHELPER_PATH="$PWD/dependencies/arkhelper"

# Extract ISO using wit
"$WIT_PATH" extract "$PWD/iso" "$PWD/_build/wii"

# Remove unnecessary files
rm "$PWD/_build/wii/sys/main.dol"
rm "$PWD/_build/wii/setup.txt"

# Copy patched main.dol and setup.txt
cp "$PWD/dependencies/patch/main.dol" "$PWD/_build/wii/sys"
cp "$PWD/dependencies/patch/setup.txt" "$PWD/_build/wii"

# Copy main_wii.hdr to appropriate directory
cp "$PWD/_build/wii_rebuild_files/main_wii.hdr" "$PWD/_build/wii/files/gen"

# Remove previous main_wii_10.ark
rm "$PWD/_build/wii/files/gen/main_wii_10.ark"

# Create patched files using arkhelper
"$ARKHELPER_PATH" patchcreator -a "$PWD/_ark" -o "$PWD/_build/wii/files/gen" "$PWD/_build/wii/files/gen/main_wii.hdr"

# Move generated files to proper location
mv "$PWD/_build/wii/files/gen/gen/main_wii.hdr" "$PWD/_build/wii/files/gen"
mv "$PWD/_build/wii/files/gen/gen/main_wii_10.ark" "$PWD/_build/wii/files/gen"

# Remove temporary directory
rmdir "$PWD/_build/wii/files/gen/gen"

# Message indicating patchcreator sux
echo "Please ignore the random error it's fine"

# Message indicating successful build
echo "GDRB ultimate should've successfully built. Make sure to add _build/wii as a game path in Dolphin and enable search subfolders so it will show up. Enjoy :)"

# Pause to keep terminal open
read -p "Press Enter to continue..."
