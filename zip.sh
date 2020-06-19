#!/bin/bash

BUILD_START=$(date +"%s")

# Colours
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

# Kernel details
KERNEL_NAME="Nightowl"
VERSION="Beta-Owl"
DATE=$(date +"%d-%m-%Y")
DEVICE="RMX1911"
FINAL_ZIP=$KERNEL_NAME-$VERSION-$DATE-$DEVICE.zip

# Toolchain repo
#TC_REPO="https://github.com/kdrag0n/proton-clang.git" if not then just clone in outside kernel

# Dirs
KERNEL_DIR=$(pwd)
ANYKERNEL_DIR=~/AnyKernel3
KERNEL_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
DT_IMAGE=$KERNEL_DIR/out/arch/arm64/boot/dt.img
UPLOAD_DIR=$KERNEL_DIR/OUTPUT/$DEVICE



# Make DT.IMG
function make_dt(){
$DTBTOOL -2 -o $DT_IMAGE -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/out/arch/arm64/boot/dts/
}

# Making zip
function make_zip() {
mkdir -p tmp_mod
make -j16 modules_install INSTALL_MOD_PATH=tmp_mod INSTALL_MOD_STRIP=1
find tmp_mod/ -name '*.ko' -type f -exec cp '{}' $ANYKERNEL_DIR/modules/system/lib/modules/ \;
cp $KERNEL_IMG $ANYKERNEL_DIR
