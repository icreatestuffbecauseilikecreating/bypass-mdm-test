#!/bin/bash

# Define colors
CYAN='\033[1;36m'
GRN='\033[1;32m'
RED='\033[1;31m'
YEL='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}--- Taheo Admin Promotion Tool ---${NC}"

# 1. Check for Root/Sudo
if [ "$EUID" -ne 0 ]; then 
  echo -e "${RED}Please run with sudo or as root${NC}"
  exit
fi

# 2. Get the list of real users (ID > 500)
# We exclude the 'Guest' account specifically
user_list=$(dscl . list /Users UniqueID | awk '$2 > 500 {print $1}' | grep -v "Guest")

if [ -z "$user_list" ]; then
    echo -e "${RED}No valid user accounts found.${NC}"
    exit 1
fi

echo -e "${YEL}Available Accounts:${NC}"
echo "-------------------"
echo "$user_list"
echo "-------------------"

read -p "Enter the username to make Admin: " target_user

if echo "$user_list" | grep -qw "$target_user"; then
    echo -e "${CYAN}Applying Admin rights to '$target_user'...${NC}"
    dscl . -append /Groups/admin GroupMembership "$target_user"
    echo -e "${GRN}Success! Reboot or log out for changes to take effect.${NC}"
else
    echo -e "${RED}Error: '$target_user' is not a valid user on this list.${NC}"
fi
