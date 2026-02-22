#!/bin/bash

# sudo bash fcn_labeldrive.sh "sda1" "NEW_LABEL"

DEV_IN="${1}"
LBL_IN="${2}"
DEV_PATH="/dev/${DEV_IN#/dev/}" # Ensures path is /dev/xxx even if user just types "sda1"

# Script Directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) >/dev/null

# Version: 2026.02.22.14.47.00 [cite: 2025-10-01]

# 1. Verify device exists
if [ ! -b "$DEV_PATH" ]; then
    echo "Error: Device $DEV_PATH not found."
    exit 1
fi

# 2. Identify Filesystem Type
FSTYPE=$(lsblk -no FSTYPE "$DEV_PATH")

if [ -z "$FSTYPE" ]; then
    echo "Error: Could not determine filesystem type for $DEV_PATH."
    exit 1
fi

echo "Detected Filesystem: $FSTYPE"

# 3. Check Label Length Limits
LBL_LEN=${#LBL_IN}
case "$FSTYPE" in
    vfat|fat32|exfat)
        if [ "$LBL_LEN" -gt 11 ]; then
            echo "Error: Label '$LBL_IN' is $LBL_LEN characters. $FSTYPE limit is 11."
            exit 1
        fi
        ;;
    ext*)
        if [ "$LBL_LEN" -gt 16 ]; then
            echo "Error: Label '$LBL_IN' is $LBL_LEN characters. $FSTYPE limit is 16."
            exit 1
        fi
        ;;
    ntfs)
        if [ "$LBL_LEN" -gt 32 ]; then
            echo "Error: Label '$LBL_IN' is $LBL_LEN characters. NTFS limit is 32."
            exit 1
        fi
        ;;
esac

# 4. Ensure Drive is Unmounted (Safe Practice with Confirmation)
if mount | grep -q "$DEV_PATH"; then
    read -p "Device $DEV_PATH is currently mounted. Unmount it now? (y/N): " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "Label change aborted."
        exit 1
    fi
    sudo umount "$DEV_PATH" || { echo "Failed to unmount."; exit 1; }
fi

# 5. Routing to specific tools
case "$FSTYPE" in
    ext2|ext3|ext4)
        sudo e2label "$DEV_PATH" "$LBL_IN"
        ;;
    vfat|fat32)
        sudo bash "$SCRIPT_DIR/fcn_install.sh" "dosfstools" & wait
        sudo fatlabel "$DEV_PATH" "${LBL_IN^^}" 
        ;;
    exfat)
        sudo bash "$SCRIPT_DIR/fcn_install.sh" "exfatprogs" & wait
        sudo exfatlabel "$DEV_PATH" "$LBL_IN"
        ;;
    ntfs)
        sudo bash "$SCRIPT_DIR/fcn_install.sh" "ntfs-3g" & wait
        sudo ntfslabel -f "$DEV_PATH" "$LBL_IN"
        ;;
    *)
        echo "Error: Filesystem '$FSTYPE' not supported."
        exit 1
        ;;
esac

# 6. Force System Refresh
# udevadm settle waits for all current udev events to handle, 
# and partprobe tells the kernel to re-read the partition table/metadata.
sudo udevadm settle
sudo partprobe "$DEV_PATH" 2>/dev/null
sleep 1

# 7. Strict Verification
NEW_LBL=$(lsblk -no LABEL "$DEV_PATH")

if [[ "${NEW_LBL^^}" == "${LBL_IN^^}" ]]; then
    echo "Success: $DEV_PATH is now labeled '$NEW_LBL'"
else
    echo "Error: Label update failed. Current label remains: '$NEW_LBL'"
    exit 1
fi