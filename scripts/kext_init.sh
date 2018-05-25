# get all of the kext sources
mkdir ~/git
cd ~/git/
git clone https://github.com/corpnewt/Lilu-and-Friends.git
cd Lilu-and-Friends
chmod +x Run.command

# setup our build environment, headlessly of course
# Xcode command line tools
CLT_LBL=`softwareupdate -l | grep -B 1 -E "Command Line (Developer|Tools)" | awk -F"*" '/^ +\\*/ {print $2}' | sed 's/^ *//' | tail -n1`.chomp
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
softwareupdate -i {CLT_LBL}
xcode-select --select /Library/Developer/CommandLineTools

# SDKs
# Extract
cd ~/git/hack-stuff
unzip setup/MacOSX10.11.sdk.zip
unzip setup/MacOSX10.10.sdk.zip
if [ -d "/Applications/Xcode.app" ]
then
    echo "Xcode is installed, continuing"
else
    echo "Install Xcode from the App Store first."
fi
echo "To copy the unzipped SDKs, run this command:"
echo "cp -r ~/git/hack-stuff/setup/MacOSX10.*.sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/"

# finished
echo "Done!"


