@echo off
"%~dp0dependencies/wit/wit" extract "%~dp0\iso" "%~dp0\_build\wii"
del "%~dp0\_build\wii\sys\main.dol"
del "%~dp0\_build\wii\setup.txt"
copy "%~dp0\dependencies\patch\main.dol" "%~dp0\_build\wii\sys"
copy "%~dp0\dependencies\patch\setup.txt" "%~dp0\_build\wii"

echo:
echo:Temporarily moving Xbox and PS3 files out of the ark path to reduce final ARK size
@%SystemRoot%\System32\robocopy.exe "%~dp0_ark" "%~dp0_temp\_ark" *.milo_xbox /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_ark" "%~dp0_temp\_ark" *.png_xbox /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_ark" "%~dp0_temp\_ark" *.bmp_xbox /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_ark" "%~dp0_temp\_ark" *.milo_ps3 /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_ark" "%~dp0_temp\_ark" *.png_ps3 /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_ark" "%~dp0_temp\_ark" *.bmp_ps3 /S /MOVE /XD "%~dp0_temp\_ark" /NDL /NFL /NJH /NJS /R:0 >nul

copy "%~dp0\_build\wii_rebuild_files\main_wii.hdr" "%~dp0\_build\wii\files\gen"
del  "%~dp0\_build\wii\files\gen\main_wii_10.ark"
"%~dp0dependencies/arkhelper" dir2ark "%~dp0\_ark" "%~dp0\_build\wii\files\gen" -n "patch_wii" -e -v 5 -s 4073741823 >nul

echo:
echo:Moving back Xbox and PS3 files
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0_ark" *.milo_xbox /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0_ark" *.png_xbox /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0_ark" *.bmp_xbox /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0_ark" *.milo_ps3 /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0_ark" *.png_ps3 /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
@%SystemRoot%\System32\robocopy.exe "%~dp0_temp\_ark" "%~dp0_ark" *.bmp_ps3 /S /MOVE /XD "%~dp0_ark" /NDL /NFL /NJH /NJS /R:0 >nul
rd _temp

GDRB ultimate should've successfully built. make sure to add _build/wii as a game path in dolphin and enable search subfolders so it will show up. enjoy :)

pause