#!/bin/bash

# Section 5.1.1: Audit home folder permissions
echo "Section 5.1.1 Secure Home Folders"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
ls -l /Users/
echo "==================================="
echo "\nNotes:"
echo "Verify the value returned is either: drwx------ or drwx--x--x"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R og-rwx /Users/<username>\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.1.2: Audit System-wide Application permissions
echo "Section 5.1.2: Audit System-wide Application permissions"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
sudo find /Applications -iname "*\.app" -type d -perm -2 -ls
echo "==================================="
echo "\nNotes:"
echo "Any applications discovered should be removed or changed."
echo "If changed the results should look like this: drwxr-xr-x"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R o-w /Applications/Bad\ Permissions.app/\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.1.3: Check System folder for world writable files (Scored)
echo "Section 5.1.3: Check System folder for world writable files (Scored)"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
sudo find /System -type d -perm -2 -ls | grep -v "Public/Drop Box"
echo "==================================="
echo "\nNotes:"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R o-w /Bad/Directory\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.1.4: Check Library folder for world writable files (Scored)
echo "Section 5.1.4: Check Library folder for world writable files (Scored)"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
sudo find /Library -type d -perm -2 -ls | grep -v "Caches"
echo "==================================="
echo "\nNotes:"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo chmod -R o-w /Bad/Directory\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.2.1: Configure account lockout threshold
echo "Section 5.2.1: Configure account lockout threshold"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | grep -A 1 '<key>policyAttributeMaximumFailedAuthentications</key>' | tail -1 | cut -d'>' -f2 | cut -d '<' -f1
echo "==================================="
echo "\nNotes:"
echo "Verify the value returned is 5 or lower."
echo "Perform the following to implement the prescribed state:"
echo "\"pwpolicy -setaccountpolicies\""
echo "(NOTE: Refer to the pwpolicy man page for examples.)"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.2.2 Set a minimum password length
echo "Section 5.2.2 Set a minimum password length"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | egrep "policyAttributePassword matches" -A1
echo "==================================="
echo "\nNotes:"
echo "Verify the value returned is 5 or lower."
echo "Perform the following to implement the prescribed state:"
echo "\"pwpolicy -setaccountpolicies\""
echo "(NOTE: Refer to the pwpolicy man page for examples.)"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.2.3 Complex passwords must contain an Alphabetic Character
echo "Section 5.2.3 Complex passwords must contain an Alphabetic Character"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | egrep "Alpha"
pwpolicy -getaccountpolicies | egrep "1 letter"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.2.4 Complex passwords must contain a Numeric Character 
echo "Section 5.2.4 Complex passwords must contain a Numeric Character "
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | egrep "Numeric"
pwpolicy -getaccountpolicies | egrep "1 number"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.2.5 Complex passwords must contain a Special Character 
echo "Section 5.2.5 Complex passwords must contain a Special Character"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | egrep "1 special"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"


# Section 5.2.6 Complex passwords must contain uppercase and lowercase letters 
echo "Section 5.2.6 Complex passwords must contain uppercase and lowercase letters"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | egrep com.apple.uppercaseAndLowercase
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"



# Section 5.2.7 Password Age
echo "Section 5.2.7 Password Age"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | egrep policyAttributeExpiresEveryNDays
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"



# Section 5.2.8 Password History
echo "Section 5.2.8 Password History"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pwpolicy -getaccountpolicies | egrep "differ from past"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"


# Section 5.3: Reduce the sudo timeout period
echo "Section 5.3: Reduce the sudo timeout period"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
sudo cat /etc/sudoers | grep timestamp
echo "==================================="
echo "\nNotes:"
echo "Verify the value returned is: Defaults timestamp_timeout=0"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo visudo\""
echo "In the \"# Defaults specification\" section, add the line:"
echo "\"Defaults timestamp_timeout=0\""
echo "------------------------------------------------------------------------"
echo "\n"


# Section 5.4 Use a separate timestamp for each user/tty combo
echo "Section 5.4 Use a separate timestamp for each user/tty combo"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
cat /etc/sudoers | egrep tty_tickets
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"


# Section 5.5: Lock keychain for inactivity
echo "Section 5.5: Lock keychain for inactivity"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
security show-keychain-info
echo "==================================="
echo "\nNotes:"
echo "Verify that a value is returned below 6 hours: Keychain \"<NULL>\" timeout=21600s"
echo "Perform the following to implement the prescribed state:"
echo "Edit keychain settings in the Utilities > Keychain Access application."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.6 Ensure login keychain is locked when the computer sleeps 
echo "Section 5.6 Ensure login keychain is locked when the computer sleeps "
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
security show-keychain-info
echo "==================================="
echo "\nNotes:"
echo "Verify that the value returned contains: Keychain \"<NULL>\" lock-on-sleep"
echo "Perform the following to implement the prescribed state:"
echo "Edit keychain settings in the Utilities > Keychain Access application."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.7: Do not enable the root account
echo "Section 5.7: Do not enable the root account"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
dscl . -read /Users/root AuthenticationAuthority
echo "==================================="
echo "\nNotes:"
echo "Verify the value returned is: \"No such key: AuthenticationAuthority\""
echo "Perform the following to implement the prescribed state:"
echo "Open System Preferences, Uses & Groups. Click the lock icon to unlock it."
echo "In the Network Account Server section, click Join or Edit."
echo "Click Open Directory Utility. Click the lock icon to unlock it."
echo "Select the Edit menu > Disable Root User."
echo "Note: Some legacy posix software might expect an available root account."
echo "------------------------------------------------------------------------"
echo "\n"


# Section 5.8: Disable automatic login
echo "Section 5.8: Disable automatic login"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
defaults read /Library/Preferences/com.apple.loginwindow | grep autoLoginUser
echo "==================================="
echo "\nNotes:"
echo "Verify that no value is returned"
echo "Perform the following to implement the prescribed state:"
echo "\"sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.9: Require password to wake from sleep or screensaver
echo "Section 5.9: Require password to wake from sleep or screensaver"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
defaults read com.apple.screensaver askForPassword
echo "==================================="
echo "\nNotes:"
echo "Verify the value returned is 1."
echo "Perform the following to implement the prescribed state:"
echo "defaults write com.apple.screensaver askForPassword -int 1"
echo "Note: Log off and back on for changes to take effect."
echo "------------------------------------------------------------------------"
echo "\n"


# Section 5.10 Ensure system is set to hibernate and Destroy FileVault key
echo "Section 5.10 Ensure system is set to hibernate and Destroy FileVault key"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
pmset -g | egrep standby
pmset -g | egrep DestroyFVKeyOnStandby
echo "==================================="
echo "\nNotes:"
echo "Verify the value returned is 1."
echo "Perform the following to implement the prescribed state:"
echo "defaults write com.apple.screensaver askForPassword -int 1"
echo "Note: Log off and back on for changes to take effect."
echo "------------------------------------------------------------------------"
echo "\n"


# Section 5.11: Require administrator password to access System Preferences
echo "Section 5.11 Require an administrator password to access system-wide preferences"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
security authorizationdb read system.preferences 2> /dev/null | grep -A1 shared | grep -E '(true|false)'
echo "==================================="
echo "\nNotes:"
echo "The response returned should be \"<false/>\""
echo "Perform the following to implement the prescribed state:"
echo "In System Preferences > Security > General > Advanced:"
echo "Check \"Require an administrator password to access system-wide preferences\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.12: Disable ability to login into another user's active+locked session
echo "Section 5.12: Disable ability to login into another user's active+locked session"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
/usr/bin/security authorizationdb read system.login.screensaver 2>/dev/null | /usr/bin/grep -A 1 "<array>" | /usr/bin/awk -F "<|>" 'END{ print $3 }'
echo "==================================="
echo "\nNotes:"
echo "No results will be returned if the system is configured as recommended."
echo "Perform the following to implement the prescribed state:"
echo "\t1. sudo vi /etc/pam.d/screensaver"
echo "\t2. Locate account required pam_group.so no_warn group=admin,wheel fail_safe"
echo "\t3. Remove \"admin,\""
echo "\t4. Save"
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.13 Create a custom message for the Login Screen 
echo "Section 5.13 Create a custom message for the Login Screen "
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
defaults read /Library/Preferences/com.apple.loginwindow.plist LoginwindowText
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

# Section 5.14 Create a Login window banner  
echo "Section 5.14 Create a Login window banner"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
cat /Library/Security/PolicyBanner.txt
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"


# 5.15 Do not enter a password-related hint
echo "Section 5.15 Do not enter a password-related hint"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
echo "Manual audit"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

# 5.16 Disable Fast User Switching
echo "Section 5.16 Disable Fast User Switching"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
echo "Manual audit"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

# 5.17 Secure individual keychains and items 
echo "Section 5.17 Secure individual keychains and items"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
echo "Manual audit"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

# 5.18 Create specialized keychains for different purposes
echo "Section 5.18 Create specialized keychains for different purposes"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
echo "Manual audit"
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

# 5.19 System Integrity Protection status
echo "Section 5.19 System Integrity Protection status"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "==================================="
/usr/bin/csrutil status
echo "==================================="
echo "------------------------------------------------------------------------"
echo "\n"

