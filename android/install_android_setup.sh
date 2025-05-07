#!/bin/bash

# Stop on error
set -e

# Set filename and target directory
TAR_FILE="android-studio-2024.3.2.14-linux.tar.gz"
INSTALL_DIR="/opt/android-studio"

echo "=== Installing dependencies for 64-bit Linux ==="
if command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
elif command -v yum &> /dev/null; then
    sudo yum install -y zlib.i686 ncurses-libs.i686 bzip2-libs.i686
else
    echo "Unsupported package manager. Install the required 32-bit libraries manually."
    exit 1
fi

echo "=== Extracting Android Studio ==="
sudo tar -xzf "$TAR_FILE" -C /opt/

echo "=== Setting permissions ==="
sudo chown -R "$USER":"$USER" "$INSTALL_DIR"

echo "=== Creating symbolic link for easy access ==="
sudo ln -sf "$INSTALL_DIR/bin/studio.sh" /usr/local/bin/android-studio

echo "=== Optionally creating desktop entry ==="
cat <<EOF > ~/.local/share/applications/android-studio.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Exec=$INSTALL_DIR/bin/studio.sh
Icon=$INSTALL_DIR/bin/studio.png
Categories=Development;IDE;
Terminal=false
EOF

chmod +x ~/.local/share/applications/android-studio.desktop

echo "=== Done! You can now launch Android Studio with: android-studio ==="
