#!/bin/bash

# Color codes for scannability
CYAN='\033[1;36m'
GRN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${CYAN}--- Taheo Verified MDM Bypass ---${NC}"

# Define the exact paths based on your volume names
SYS_VOL="/Volumes/Macintosh HD"
DATA_VOL="/Volumes/Macintosh HD - Data"

# 1. Check if the volumes are actually mounted
if [ ! -d "$SYS_VOL" ]; then
    echo -e "${RED}Error: 'Macintosh HD' not found.${NC}"
    echo "Go to Disk Utility and ensure it is mounted."
    exit 1
fi

# 2. Block MDM Domains (The "Muzzle")
echo -e "${CYAN}Blocking MDM domains...${NC}"
echo "0.0.0.0 deviceenrollment.apple.com" >> "$SYS_VOL/etc/hosts"
echo "0.0.0.0 mdmenrollment.apple.com" >> "$SYS_VOL/etc/hosts"
echo "0.0.0.0 iprofiles.apple.com" >> "$SYS_VOL/etc/hosts"

# 3. Create Setup Done Flag
# This forces the Mac to skip the "Remote Management" screen
echo -e "${CYAN}Suppressing Setup Assistant...${NC}"
touch "$DATA_VOL/private/var/db/.AppleSetupDone"

# 4. Wipe/Fake the Enrollment Records
echo -e "${CYAN}Clearing enrollment flags...${NC}"
rm -rf "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord"
rm -rf "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound"
touch "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled"
touch "$SYS_VOL/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound"

echo -e "---------------------------------------"
echo -e "${GRN}SUCCESS!${NC}"
echo -e "1. Exit Terminal and Reboot."
echo -e "2. ${RED}DO NOT CONNECT TO WI-FI${NC} until you reach the desktop."
echo -e "3. Create your local user account normally."
