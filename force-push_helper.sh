#!/bin/bash

declare -A REPOS=(
    ["build/make"]="git@github.com:P-404/android_build.git"
    ["build/soong"]="git@github.com:P-404/android_build_soong.git"
    ["bootable/recovery"]="git@github.com:P-404/android_bootable_recovery.git"
    ["bionic"]="git@github.com:P-404/android_bionic.git"
    ["device/qcom/common"]="git@github.com:P-404/android_device_qcom_common.git"
    ["device/404/sepolicy"]="git@github.com:P-404/android_device_404_sepolicy.git"
    ["device/qcom/sepolicy_vndr"]="git@github.com:P-404/android_device_qcom_sepolicy_vndr.git"
    ["device/qcom/kernelscripts"]="git@github.com:P-404/android_kernel_build.git"
    ["external/fastrpc"]="git@github.com:P-404/android_external_fastrpc.git"
    ["external/json-c"]="git@github.com:P-404/android_external_json-c.git"
    ["external/tinycompress"]="git@github.com:P-404/android_external_tinycompress.git"
    ["hardware/libhardware"]="git@github.com:P-404/android_hardware_libhardware.git"
    ["hardware/qcom/wlan"]="git@github.com:P-404/android_hardware_qcom_wlan.git"
    ["hardware/st/nfc"]="git@github.com:P-404/android_hardware_st_nfc.git"
    ["hardware/lineage/compat"]="git@github.com:P-404/android_hardware_lineage_compat.git"
    ["manifest"]="git@github.com:P-404/android_manifest.git"
    ["system/core"]="git@github.com:P-404/android_system_core.git"
    ["vendor/qcom/opensource/softap"]="git@github.com:P-404/android_vendor_qcom_opensource_softap.git"
    ["vendor/404"]="git@github.com:P-404/android_vendor_404.git"
    ["vendor/overlays/404"]="git@github.com:P-404/android_vendor_overlays_404.git"
    ["vendor/qcom/common"]="git@github.com:P-404/proprietary_vendor_qcom_common.git"
    ["vendor/qcom/sdclang"]="git@github.com:P-404/proprietary_vendor_qcom_sdclang.git"
    ["vendor/qcom/opensource/commonsys-intf/display"]="git@github.com:P-404/android_vendor_qcom_opensource_commonsys-intf_display.git"
    ["vendor/qcom/opensource/commonsys/display"]="git@github.com:P-404/android_vendor_qcom-opensource_display-commonsys.git"
    ["vendor/qcom/opensource/commonsys-intf/bluetooth"]="git@github.com:P-404/android_vendor_qcom-opensource_bluetooth-commonsys-intf.git"
    ["vendor/qcom/opensource/commonsys-intf/wfd"]="git@github.com:P-404/android_vendor_qcom_opensource_commonsys-intf_wfd.git"
    ["vendor/qcom/opensource/data-ipa-cfg-mgr"]="git@github.com:P-404/android_vendor_qcom_opensource_data-ipa-cfg-mgr.git"
    ["vendor/qcom/opensource/data-ipa-cfg-mgr-legacy"]="git@github.com:P-404/android_vendor_qcom_opensource_data-ipa-cfg-mgr.git"
    ["vendor/qcom/opensource/power"]="git@github.com:P-404/android_vendor_qcom-opensource_power.git"
    ["vendor/qcom/opensource/dataservices"]="git@github.com:P-404/android_vendor_qcom-opensource_dataservices.git"
    ["vendor/qcom/opensource/vibrator"]="git@github.com:P-404/android_vendor_qcom-opensource_vibrator.git"
)

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

REMOTE_NAME="404"
REVISION="vito"

echo -n "Enter the branch name you want to create and force push: "
read BRANCH_NAME

if [ -z "$BRANCH_NAME" ]; then
    echo -e "${RED}Error: Branch name cannot be empty${NC}"
    exit 1
fi

success_count=0
failed_count=0
failed_paths=()

for path in "${!REPOS[@]}"; do
    echo -e "\n${GREEN}Processing: $path${NC}"
    
    if [ ! -d "$path" ]; then
        mkdir -p "$path"
        git clone "${REPOS[$path]}" "$path"
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to clone repository for $path${NC}"
            ((failed_count++))
            failed_paths+=("$path")
            continue
        fi
    fi
    
    cd "$path" || {
        echo -e "${RED}Failed to change directory to $path${NC}"
        ((failed_count++))
        failed_paths+=("$path")
        continue
    }
    
    # Remove existing remotes and add new one
    git remote remove origin 2>/dev/null
    git remote remove 404 2>/dev/null
    
    if ! git remote add "${REMOTE_NAME}" "${REPOS[$path]}"; then
        echo -e "${RED}Failed to set remote for $path${NC}"
        ((failed_count++))
        failed_paths+=("$path")
        cd - > /dev/null
        continue
    fi
    
    # Fetch from new remote
    git fetch "${REMOTE_NAME}" || {
        echo -e "${RED}Failed to fetch from remote for $path${NC}"
        ((failed_count++))
        failed_paths+=("$path")
        cd - > /dev/null
        continue
    }
    
    # Try to checkout vito branch first
    git checkout "${REMOTE_NAME}/${REVISION}" 2>/dev/null || {
        echo -e "${RED}Failed to checkout ${REVISION} branch for $path${NC}"
        ((failed_count++))
        failed_paths+=("$path")
        cd - > /dev/null
        continue
    }
    
    if ! git checkout -b "$BRANCH_NAME" 2>/dev/null; then
        if ! git checkout "$BRANCH_NAME" 2>/dev/null; then
            echo -e "${RED}Failed to create/checkout branch $BRANCH_NAME${NC}"
            ((failed_count++))
            failed_paths+=("$path")
            cd - > /dev/null
            continue
        fi
    fi
    
    if git push -f "${REMOTE_NAME}" "$BRANCH_NAME"; then
        echo -e "${GREEN}Successfully processed $path${NC}"
        ((success_count++))
    else
        echo -e "${RED}Failed to force push in $path${NC}"
        ((failed_count++))
        failed_paths+=("$path")
    fi
    
    cd - > /dev/null
done

echo -e "\n${GREEN}=== Operation Summary ===${NC}"
echo -e "${GREEN}Successfully processed: $success_count repositories${NC}"
echo -e "${RED}Failed: $failed_count repositories${NC}"

if [ ${#failed_paths[@]} -gt 0 ]; then
    echo -e "\n${RED}Failed paths:${NC}"
    printf '%s\n' "${failed_paths[@]}"
fi
