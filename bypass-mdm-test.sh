#!/bin/bash

# 1. FIND THE VOLUMES DYNAMICALLY
# This looks for the volume that contains the System files
SYS_VOL=$(ls -d /Volumes/* | grep -v "Recovery" | grep -v "Data" | head -n 1)
# This looks for the Data volume specifically
DATA_VOL=$(ls -d /Volumes/* | grep "Data" | head -n 1)

echo "System Volume: $SYS_VOL"
echo "Data Volume: $DATA_VOL"

# 2. THE "SECRET SAUCE" (Flags and Blocks)
# This mimics exactly what the Assaf Dori script does but with correct paths

# Block domains (redirects to nowhere)
echo "0.0.0.0 deviceenrollment.apple.com" >> "$SYS_VOL/etc/hosts"
echo "0.0.0.0 mdmenrollment.apple.com" >> "$SYS_VOL/etc/hosts"
echo "0.0.0.0 iprofiles.apple.com" >> "$SYS_VOL/etc/hosts"

# Tell the Mac the setup is done so it skips the MDM screen
touch "$DATA_VOL/private/var/db/.AppleSetupDone"

# Remove the 'Cloud Config' records that trigger the MDM pop-up
rm -rf "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord"
rm -rf "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound"
touch "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled"
touch "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound"

echo "Process Complete. Please reboot your Mac."
