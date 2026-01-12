#!/bin/bash

# Color codes for the shop
CYAN='\033[1;36m'
GRN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${CYAN}--- Taheo Global MDM & ZuluDesk Purge ---${NC}"

# Define paths
SYS_VOL="/Volumes/Macintosh HD"
DATA_VOL="/Volumes/Macintosh HD - Data"

# 1. FORCE MOUNT (Ensures we can see the files)
diskutil mount "$SYS_VOL"
diskutil mount "$DATA_VOL"
mount -uw "$SYS_VOL" 2>/dev/null

# 2. SEARCH AND DESTROY (The "ZuluDesk" Nuke)
# This looks for any file/folder containing "zuludesk" or "jamf" and deletes it.
echo -e "${CYAN}Searching for hidden MDM components...${NC}"
for keyword in "zuludesk"; do
    echo -e "Purging items matching: ${RED}$keyword${NC}"
    find "$SYS_VOL" -iname "*$keyword*" -exec rm -rf {} + 2>/dev/null
    find "$DATA_VOL" -iname "*$keyword*" -exec rm -rf {} + 2>/dev/null
done

# 3. DIRECT PURGE OF MDM DATABASES
# Even if the name doesn't match, these folders hold the "lock"
echo -e "${CYAN}Purging MDM database folders...${NC}"
rm -rf "$SYS_VOL/var/db/ConfigurationProfiles"
rm -rf "$SYS_VOL/Library/Managed Preferences"
rm -rf "$DATA_VOL/Library/Managed Preferences"

# Recreate the folder structure so the OS boots cleanly
mkdir -p "$SYS_VOL/var/db/ConfigurationProfiles/Settings"

# 4. THE BLOCK (Hosts file)
echo -e "${CYAN}Applying Network Muzzle...${NC}"
echo "0.0.0.0 deviceenrollment.apple.com" >> "$SYS_VOL/etc/hosts"
echo "0.0.0.0 mdmenrollment.apple.com" >> "$SYS_VOL/etc/hosts"
echo "0.0.0.0 iprofiles.apple.com" >> "$SYS_VOL/etc/hosts"
echo "0.0.0.0 api.zuludesk.com" >> "$SYS_VOL/etc/hosts"

# 5. THE SKIP (Setup Assistant)
echo -e "${CYAN}Creating SetupDone flag...${NC}"
mkdir -p "$DATA_VOL/private/var/db/"
touch "$DATA_VOL/private/var/db/.AppleSetupDone"

# 6. FAKE RECORDS (Stops the "Nag" notifications)
touch "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled"
touch "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound"

echo -e "---------------------------------------"
echo -e "${GRN}PURGE COMPLETE!${NC}"
echo -e "1. Reboot and ${RED}SKIP WI-FI${NC}."
echo -e "2. Create your user account."
