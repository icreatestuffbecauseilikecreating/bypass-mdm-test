# MDM Configuration Test Script (Educational Use Only)

### ⚠️ DISCLAIMER
**THIS IS A TEST AND SHOULD NOT BE USED FOR REAL ACTUAL REASON.**
This script is provided for testing and educational purposes only. Modifying system files can lead to OS instability. Use at your own risk.

---

### 📋 Description
This script is designed for local IT administrators and hardware resellers to test the behavior of macOS when Mobile Device Management (MDM) enrollment triggers are locally suppressed. It focuses on testing local system persistence and network redirection.

---

### 🚀 Usage Instructions

1. **Boot into Recovery Mode:** - **Intel:** Restart and hold `Command (⌘) + R`.
   - **Apple Silicon (M1/M2/M3):** Shut down, then hold the Power button until "Loading Startup Options" appears. Select **Options > Continue**.
2. **Open Terminal:** Navigate to `Utilities > Terminal` in the top menu bar.
3. **Ensure Connectivity:** Verify the device is connected to the internet via the Wi-Fi icon.
4. **Execute the Command:** Copy and paste the following line into the Terminal:

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/icreatestuffbecauseilikecreating/bypass-mdm-test/refs/heads/main/bypass-mdm-test.sh](https://raw.githubusercontent.com/icreatestuffbecauseilikecreating/bypass-mdm-test/refs/heads/main/bypass-mdm-test.sh))"
```
---

### 🛡️ User Management Tool (Promote to Admin)

This section is for managing user privileges on devices that have already passed the initial setup but require administrative access.

**File:** `promote.sh`  
**Description:** Scans the system for active local users (ID > 500), displays a list of valid accounts, and allows you to promote a specific user to the `admin` group.

#### 📋 How to Use:
1. **Open Terminal:** This can be done within the standard macOS desktop (using `sudo`) or via Recovery Mode.
2. **Execute the Command:** Copy and paste the following line:

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/icreatestuffbecauseilikecreating/bypass-mdm-test/refs/heads/main/promote.sh](https://raw.githubusercontent.com/icreatestuffbecauseilikecreating/bypass-mdm-test/refs/heads/main/promote.sh))"
