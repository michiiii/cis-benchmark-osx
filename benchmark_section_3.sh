#!/bin/bash


# Section 3.1: Enable security auditing
echo "Section 3.1: Enable security auditing"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================================="
sudo launchctl list | grep -i auditd
echo "======================================================="
echo "\nNotes:"
echo "Verify that \"com.apple.auditd\" appears."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist\""
echo "------------------------------------------------------------------------"
echo "\n"


# Section Configure Security Auditing Flags per local organizational requirements
echo "Section 3.2: Configure Security Auditing Flags per local organizational requirements"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================================="
sudo egrep "^flags:" /etc/security/audit_control
echo "======================================================="
echo "\nNotes:"
echo "Verify that at least the following flags are present:"
echo "\tlo - audit successful/failed login/logout events"
echo "\tad - audit successful/failed administrative events"
echo "\tfd - audit successful/failed file deletion events"
echo "\tfm - audit successful/failed file attribute modification events"
echo "\t-all - audit all failed events across all audit classes"
echo "Perform the following to implement the prescribed state:"
echo "Open the /etc/security/audit_control file and find the flags line."
echo "Add the lo, ad, fd, fm, -all flags."
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.3: Ensure security auditing retention
echo "Section 3.3: Ensure security auditing retention"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================================="
sudo cat /etc/security/audit_control | egrep expire-after
echo "======================================================="
echo "\nNotes:"
echo "Verify that \"com.apple.auditd\" appears."
echo "Perform the following to implement the prescribed state:"
echo "\"sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist\""
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.4 Control access to audit records
echo "Section 3.4 Control access to audit records"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================================="
ls -le /etc/security/audit_control
sudo ls -le /var/audit/
echo "======================================================="
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.4 Control access to audit records
echo "Section 3.4 Control access to audit records"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================================="
ls -le /etc/security/audit_control
sudo ls -le /var/audit/
echo "======================================================="
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.5 Retain install.log for 365 or more days
echo "Section 3.5 Retain install.log for 365 or more days"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================================="
grep -i ttl /etc/asl/com.apple.install
echo "======================================================="
echo "------------------------------------------------------------------------"
echo "\n"

# Section 3.6 Ensure Firewall is configured to log
echo "Section 3.6 Ensure Firewall is configured to log"
echo "------------------------------------------------------------------------"
echo "Output:"
echo "======================================================="
/usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode
echo "======================================================="
echo "------------------------------------------------------------------------"
echo "\n"
