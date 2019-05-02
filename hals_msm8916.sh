#!/bin/bash

echo "Clone HALS MSM8916"
rm -rf hardware/qcom/audio-caf/msm8916
rm -rf hardware/qcom/display-caf/msm8916
rm -rf hardware/qcom/media-caf/msm8916
rm -rf hardware/qcom/wlan-caf/msm8916
git clone https://github.com/Lineageos/android_hardware_qcom_audio.git -b lineage-16.0-caf-8916 hardware/qcom/audio-caf/msm8916
git clone https://github.com/Lineageos/android_hardware_qcom_display.git -b lineage-16.0-caf-8916 hardware/qcom/display-caf/msm8916
git clone https://github.com/Lineageos/android_hardware_qcom_media.git -b lineage-16.0-caf-8916 hardware/qcom/media-caf/msm8916
git clone https://github.com/Lineageos/android_hardware_qcom_wlan.git -b lineage-16.0-caf hardware/qcom/wlan-caf/msm8916
echo "done"
