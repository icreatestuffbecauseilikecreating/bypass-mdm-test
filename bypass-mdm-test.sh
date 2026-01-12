TARGET="/Volumes/Macintosh HD"

echo "0.0.0.0 deviceenrollment.apple.com" >> "$TARGET/etc/hosts"
echo "0.0.0.0 mdmenrollment.apple.com" >> "$TARGET/etc/hosts"
echo "0.0.0.0 iprofiles.apple.com" >> "$TARGET/etc/hosts"

touch "$TARGET - Data/private/var/db/.AppleSetupDone"

rm -rf "$TARGET/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord"
rm -rf "$TARGET/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound"
touch "$TARGET/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound"
