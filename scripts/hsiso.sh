#!/bin/bash
 
 # Mount the installer image
 hdiutil attach /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app
 
 # Create the HighSierra Blank ISO Image of 7316mb with a Single Partition - Apple Partition Map
 hdiutil create -o /tmp/HighSierra.cdr -size 7316m -layout SPUD -fs HFS+J
 
 # Mount the HighSierra Blank ISO Image
 hdiutil attach /tmp/HighSierra.cdr.dmg -noverify -nobrowse -mountpoint /Volumes/install_build
 
 # Restore the Base System into the HighSierra Blank ISO Image
 asr restore -source /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/BaseSystem.dmg  -target /Volumes/install_build -noprompt -noverify -erase
 
 # Remove Package link and replace with actual files
 rm /Volumes/OS\ X\ Base\ System/System/Installation/Packages
 cp -rp /Volumes/install_app/Packages /Volumes/OS\ X\ Base\ System/System/Installation/
 
 # Copy High Sierra installer dependencies
 cp -rp /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/BaseSystem.chunklist /Volumes/OS\ X\ Base\ System/BaseSystem.chunklist
 cp -rp /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/BaseSystem.dmg /Volumes/OS\ X\ Base\ System/BaseSystem.dmg
 
 # Unmount the installer image
 hdiutil detach /Volumes/install_app
 
 # Unmount the HighSierra installer
 hdiutil detach /Volumes/OS\ X\ Base\ System/
 
 # Convert the High Sierra ISO Image to ISO/CD master (Optional)
 hdiutil convert /tmp/HighSierra.cdr.dmg -format UDTO -o /tmp/HighSierra.iso
 
 # Rename the HighSierra ISO Image and move it to the desktop
 mv /tmp/HighSierra.iso.cdr ~/Desktop/HighSierra.iso

 # delete iso in /tmp
 rm /tmp/HighSierra.cdr.dmg
