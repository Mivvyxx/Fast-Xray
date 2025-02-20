#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Sorry. Use this script as root"
    exit 1
fi

echo "Check versions"
LATEST_VERSION=$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')

if [ -f "/etc/xray/version" ]; then
    LATEST_VERSION_INSTALLED=$(cat /etc/xray/version)
else
    echo "Version file at /etc/xray/version not found!"
    LATEST_VERSION="None"
fi

if [ "$LATEST_VERSION" = "$LATEST_VERSION_INSTALLED" ]; then
    echo "You have the latest version - $LATEST_VERSION_INSTALLED"
    exit 0
fi

echo "Current version $LATEST_VERSION_INSTALLED"
echo "New version available $LATEST_VERSION"

read -p "Do you want to upgrade? (y/N): " CONFIRM && [[ $CONFIRM == [yY] || $CONFIRM == [yY][eE][sS] ]] || exit 0

echo "Install new version"

# Check if 'unzip' is installed
if ! command -v unzip &> /dev/null; then
    echo "'unzip' is required but not installed. Install it and try again"
    exit 1
fi

TEMP_DIR=$(mktemp -d)
ARCHIVE_PATH="$TEMP_DIR/Xray-linux-64.zip"
BIN_PATH="$TEMP_DIR/xray"
TARGET_FILE="/usr/bin/xray"

# Download the latest version
if ! curl -L -s -o $ARCHIVE_PATH https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip; then
    echo "Error downloading Xray package"
    exit 1
fi
echo "Downloaded!"

# Unzip the archive
echo "Unzip archive"
if ! unzip -q $ARCHIVE_PATH -d $TEMP_DIR; then
    echo "Error unzipping the archive"
    exit 1
fi
echo "Unzipped!"

# Remove old version if exists
if [ -f "$TARGET_FILE" ]; then
    echo "Removing old version: $TARGET_FILE"
    rm -f $TARGET_FILE
fi

# Install the new version
echo "Install new version"
if ! mv $BIN_PATH $TARGET_FILE; then
    echo "Failed to install the new version"
    exit 1
fi

# Check if the directory exists and create it if not
if [ ! -d "/etc/xray" ]; then
    echo "Directory /etc/xray does not exist. Creating it"
    mkdir -p /etc/xray
fi

# Save the new version to the version file
echo "$LATEST_VERSION" > /etc/xray/version


# Clean up temporary files
echo "Clear temporary files"
rm -rf $TEMP_DIR

echo "Done!"
exit 0
