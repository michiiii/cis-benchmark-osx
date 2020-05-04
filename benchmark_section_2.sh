#!/bin/bash

# Section 2.1 Bluetooth:
echo "Section 2.1.1: Turn off Bluetooth, if no paired devices exist (Scored)"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState
echo "======================================"
echo "\nNotes:"
echo "Output value should be 0. If the value returned is 1, Bluetooth is enabled."
echo "If Bluetooth is enabled, use this command to see the paired devices:"
echo "\"system_profiler | grep "Bluetooth:" -A 20 | grep Connectable\""
echo "Use these commands to disable Bluetooth:"
echo "\"sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0\""
echo "\"sudo killall -HUP blued\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.1.2: Turn off Bluetooth's "Discoverable mode"
echo "Section 2.1.2: Turn off Bluetooth's \"Discoverable mode\""
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
/usr/sbin/system_profiler SPBluetoothDataType | grep -i discoverable
echo "======================================"
echo "\nNotes:"
echo "Return value should be \"Off.\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.1.3: Check that Bluetooth is included in the menu bar
echo "Section 2.1.3: Check that Bluetooth is included in the menu bar"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read com.apple.systemuiserver menuExtras | grep Bluetooth.menu
echo "======================================"
echo "\nNotes:"
echo "Verify the value returned is: /System/Library/CoreServices/Menu Extras/Bluetooth.menu"
echo "To add Bluetooth to the system menu run the following command:"
echo "\"defaults write com.apple.systemuiserver menuExtras -array-add \"/System/Library/CoreServices/Menu Extras/Bluetooth.menu\"\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.2.1: Set time and date automatically
echo "Section 2.2.1: Set time and date automatically"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo systemsetup -getusingnetworktime
echo "======================================"
echo "\nNotes:"
echo "Verify that the results are: Network Time: On"
echo "If the result does not match, use the following commands:"
echo "\"sudo systemsetup -setnetworktimeserver <timeserver>\""
echo "\"sudo systemsetup –setnetworktimeserver on\""
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.2.2: Ensure time set is within appropriate limits
echo "Section 2.2.2: Ensure time set is within appropriate limits"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo systemsetup -getnetworktimeserver
echo "======================================"
echo "\nNotes:"
echo "check manually the time drift: sntp your.time.server | grep +/-"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.3.1: Audit all system screensaver times
echo "Section 2.3.1: Audit all system user screensaver times"
echo "------------------------------------------------------------------------"
echo "Checking all user's screensaver times. Values should be < 1200."
echo "Output:"
echo "======================================"
UUID=`ioreg -rd1 -c IOPlatformExpertDevice | grep "IOPlatformUUID" | sed -e 's/^.*"\(.*\)"$/\1/'`
for i in $(find /Users -type d -maxdepth 1)
do
PREF=$i/Library/Preferences/ByHost/com.apple.screensaver.$UUID
if [ -e $PREF.plist ]
then
echo -n "Checking User: '$i': "
defaults read $PREF.plist idleTime 2>&1
fi
done
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.3.2: Secure screen saver corners
echo "Section 2.3.2: Secure screen saver corners"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read ~/Library/Preferences/com.apple.dock | grep -i corner
echo "======================================"
echo "\nNotes:"
echo "Verify that 6 is not returned for any key value for any user."
echo "Remove corners in System Preferences > Mission Control > Hot Corners"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.3.3: Familiarize users with screen lock tools or corner to Start Screen
echo "Section 2.3.3: Familiarize users with screen lock tools or corner to Start Screen Saver"
echo "------------------------------------------------------------------------"
echo "Check that Display sleep is set to a larger value than screensaver:"
echo "Output:"
echo "======================================"
defaults read ~/Library/Preferences/com.apple.dock | grep -i corner
echo "======================================"
echo "\nNotes:"
echo "Check that this value is larger than the screensaver timer by going to:"
echo "System Preferences: Energy Saver, and check sliders."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.1: Disable remote Apple events
echo "Section 2.4.1: Disable remote Apple events"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo systemsetup -getremoteappleevents
echo "======================================"
echo "\nNotes:"
echo "Verify the value returned is Remote Apple Events: Off"
echo "To remedy this if the value does not match, run the following command:"
echo "\"sudo systemsetup -setremoteappleevents off\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.2: Disable Internet sharing
echo "Section 2.4.2: Disable Internet sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo defaults read /Library/Preferences/SystemConfiguration/com.apple.nat | grep -i Enabled
echo "======================================"
echo "\nNotes:"
echo "The file should not exist or Enabled = 0 for all network interfaces."
echo "Perform the following to implement the prescribed state:"
echo "Uncheck \"Internet Sharing\" in System Preferences > Sharing"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.3: Disable screen sharing
echo "Section 2.4.3: Disable screen sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo launchctl load /System/Library/LaunchDaemons/com.apple.screensharing.plist
echo "======================================"
echo "\nNotes:"
echo "Verify the value returned is Service is disabled"
echo "To fix, uncheck \"Screen Sharing\" in System Preferences > Sharing."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.4: Disable printer sharing
echo "Section 2.4.4: Disable printer sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
system_profiler SPPrintersDataType | egrep "System Printer Sharing"
echo "======================================"
echo "\nNotes:"
echo "All output should be System Printer Sharing: No. If Sharing: Yes is in the output there are still shared printers"
echo "To fix, uncheck \"Printer Sharing\" in System Preferences > Sharing."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.5: Disable remote login
echo "Section 2.4.5: Disable remote login"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo systemsetup -getremotelogin
echo "======================================"
echo "\nNotes:"
echo "Verify the value returned is Remote Login: Off"
echo "To implement the prescribed state run the following command:"
echo "\"sudo systemsetup -setremotelogin off\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.6: Disable DVD or CD Sharing
echo "Section 2.4.6: Disable DVD or CD Sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo launchctl list | egrep ODSAgent
echo "======================================"
echo "\nNotes:"
echo "If "com.apple.ODSAgent" appears in the result the control is not in place."
echo "To implement the prescribed state:"
echo "Uncheck \"DVD or CD Sharing\" in System Preferences > Sharing"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.7: Disable bluetooth sharing
echo "Section 2.4.7: Disable bluetooth sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
system_profiler SPBluetoothDataType | grep State
echo "======================================"
echo "\nNotes:"
echo "Verify that all values are Disabled."
echo "To implement the prescribed state:"
echo "Uncheck \"Bluetooth Sharing\" in System Preferences > Sharing"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.4.8: Disable file sharing
echo "Section 2.4.8: Disable file sharing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Checking the Apple File Server status:"
sudo launchctl list | egrep AppleFileServer
echo "Checking the Windows File Server status:"
sudo launchctl list | egrep com.apple.smbd
echo "======================================"
echo "\nNotes:"
echo "Ensure no output is present"
echo "To implement the prescribed state run the following command(s):"
echo "\"sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist\""
echo "\"sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist \""
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.4.9: Disable remote management
echo "Section 2.4.9: Disable remote management"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
ps -ef | egrep ARDAgent
echo "======================================"
echo "\nNotes:"
echo "Ensure /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/MacOS/ARDAgent is not present"
echo "To implement the prescribed state:"
echo "Turn off Remote Management in System Preferences > Sharing."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.10 Disable Content Caching
echo "Section 2.4.10 Disable Content Caching"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Check Manually"
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.4.11 Disable Media Sharing (Scored)
echo "Section 2.4.11 Disable Media Sharing (Scored)"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Check Manually"
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.1.1 Enable FileVault
echo "Section 2.5.1.1 Enable FileVault"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
fdesetup status
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.1.2 Ensure all user storage APFS volumes are encrypted
echo "Section 2.5.1.2 Ensure all user storage APFS volumes are encrypted"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
diskutil ap list
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.1.3 Ensure all user storage CoreStorage volumes are encrypted 
echo "Section 2.5.1.3 Ensure all user storage CoreStorage volumes are encrypted"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
diskutil cs list
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.2 Enable Gatekeeper
echo "Section 2.5.2 Enable Gatekeeper"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo spctl --status
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.3 Enable Firewall
echo "Section 2.5.3 Enable Firewall"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read /Library/Preferences/com.apple.alf globalstate
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.4 Enable Firewall Stealth Mode
echo "Section 2.5.4 Enable Firewall Stealth Mode"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
/usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.5 Review Application Firewall Rules
echo "Section 2.5.5 Review Application Firewall Rules"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
/usr/libexec/ApplicationFirewall/socketfilterfw --listapps
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.6 Enable Location Services
echo "Section 2.5.6 Enable Location Services"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.7 Monitor Location Services Access
echo "Section 2.5.6 Enable Location Services"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
sudo defaults read /var/db/locationd/clients.plist
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.8 Disable Analytics & Improvements sharing with Apple
echo "Section 2.5.8 Disable Analytics & Improvements sharing with Apple"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Manual audit"
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.5.9 Review Advertising settings
echo "Section 2.5.9 Review Advertising settings"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read ~/Library/Preferences/com.apple.AdLib.plist | egrep forceLimitAdTracking
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.6.1 iCloud configuration (Not Scored)
echo "Section 2.6.1 iCloud configuration (Not Scored)"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read ~/Library/Preferences/MobileMeAccounts.plist
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.6.2 iCloud keychain
echo "Section 2.6.2 iCloud keychain"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Manual Review: Review defaults read ~/Library/Preferences/MobileMeAccounts.plist"
read ~/Library/Preferences/MobileMeAccounts.plist
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.6.3 iCloud Drive
echo "Section 2.6.3 iCloud Drive"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Manual Review: Review defaults read ~/Library/Preferences/MobileMeAccounts.plist"
read ~/Library/Preferences/MobileMeAccounts.plist
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.6.4 iCloud Drive Document sync
echo "Section 2.6.4 iCloud Drive Document sync"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Manual Review: Review defaults read ~/Library/Preferences/MobileMeAccounts.plist"
read ~/Library/Preferences/MobileMeAccounts.plist
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.6.5 iCloud Drive Document sync
echo "Section 2.6.5 iCloud Drive Document sync"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
ls -l ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/ | grep total
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.7.1 Time Machine Auto-Backup
echo "Section 2.7.1 Time Machine Auto-Backup"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read /Library/Preferences/com.apple.TimeMachine.plist AutoBackup
echo "Backup frequency"
defaults read /Library/Preferences/com.apple.TimeMachine.plist | egrep Snapshot
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.7.2 Time Machine Volumes Are Encrypted
echo "Section 2.7.2 Time Machine Volumes Are Encrypted"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read /Library/Preferences/com.apple.TimeMachine.plist | egrep LastKnownEncryptionState
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.8 Pair the remote control infrared receiver if enabled
echo "Section 2.8 Pair the remote control infrared receiver if enabled"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
/usr/sbin/system_profiler SPUSBDataType
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.9 Enable Secure Keyboard Entry in terminal.app
echo "Section 2.9 Enable Secure Keyboard Entry in terminal.app"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
defaults read -app Terminal SecureKeyboardEntry
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.10 Securely delete files as needed (Not Scored)
echo "Section 2.10 Securely delete files as needed (Not Scored)"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Manual Audit"
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"


# Section 2.11 Ensure EFI version is valid and being regularly checked
echo "Section 2.11 Ensure EFI version is valid and being regularly checked "
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Manual Audit"
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 2.12 Disable "Wake for network access" and "Power Nap"
echo "Section 2.12 Disable \"Wake for network access\" and \"Power Nap\""
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================"
echo "Wake for network access"
pmset -g | egrep womp
echo "Power Nap"
pmset -g | egrep powernap
echo "======================================"
echo "------------------------------------------------------------------------"
echo "\n"

