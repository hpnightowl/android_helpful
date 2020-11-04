#!/bin/bash

rm -rf device/oneplus
rm -rf vendor/oneplus
rm -rf kernel/oneplus
git clone https://github.com/hpnightowl/device_oneplus_fajita.git device/oneplus/fajita
git clone https://github.com/hpnightowl/device_oneplus_sdm845-common.git device/oneplus/sdm845-common
git clone https://github.com/hpnightowl/vendor_oneplus.git vendor/oneplus
git clone https://github.com/hpnightowl/kernel_oneplus_sdm845.git kernel/oneplus/sdm845
git clone https://github.com/LineageOS/android_device_oneplus_common device/oneplus/common
rm -rf hardware/qcom-caf/sdm845/audio
rm -rf hardware/qcom-caf/sdm845/display
rm -rf hardware/qcom-caf/sdm845/media

git clone  https://github.com/LineageOS/android_hardware_qcom_audio -b lineage-17.1-caf-sdm845 hardware/qcom-caf/sdm845/audio
git clone  https://github.com/LineageOS/android_hardware_qcom_display -b lineage-17.1-caf-sdm845 hardware/qcom-caf/sdm845/display
git clone  https://github.com/LineageOS/android_hardware_qcom_media -b lineage-17.1-caf-sdm845 hardware/qcom-caf/sdm845/media
rm -rf vendor/qcom/opensource/interfaces
git clone https://github.com/PotatoProject-next/vendor_qcom_opensource_interfaces.git vendor/qcom/opensource/interfaces
