#!/bin/bash

# 1. Automatically find the System Volume (the one with /etc/hosts)
# This looks for any volume that contains the 'etc' folder
TARGET=$(ls -d /Volumes/* | grep -v "Recovery" | grep -v "Data" | head -n 1)

# 2. Automatically find the Data Volume
# This looks for the volume that actually stores user data
DATA_VOL=$(ls -d /Volumes/* | grep "Data" | head -n 1)

echo "Targeting System: $TARGET"
echo "Targeting Data: $DATA_VOL"

# --- The Core Logic ---

# Block MDM Domains
echo "0.0.0.0 deviceenrollment.apple.com" >> "$TARGET/etc/hosts"
echo "0.0.0.0 mdmenrollment.apple.com" >> "$TARGET/etc/hosts"
echo "0.0.0.0 iprofiles.apple.com" >> "$TARGET/etc/hosts"

# Suppress Setup Assistant
if [ -d "$DATA_VOL" ]; then
    touch "$DATA_VOL/private/var/db/.AppleSetupDone"
else
    # Fallback if Data volume isn't explicitly named "Data"
    touch "$TARGET/private/var/db/.AppleSetupDone"
fi

# Remove Records
rm -rf "$TARGET/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord"
rm -rf "$TARGET/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound"
touch "$TARGET/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled"
touch "$TARGET/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound"

echo "Done! You can now reboot."
