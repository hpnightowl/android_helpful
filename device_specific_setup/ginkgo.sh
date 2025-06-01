#!/bin/bash

git clone https://github.com/hpnightowl/android_device_xiaomi_ginkgo.git device/xiaomi/ginkgo
git clone https://github.com/hpnightowl/android_vendor_xiaomi_trinket-common.git vendor/xiaomi/trinket-common
git clone https://github.com/hpnightowl/android_device_xiaomi_trinket-common.git device/xiaomi/trinket-common
git clone https://github.com/hpnightowl/android_vendor_xiaomi_ginkgo.git vendor/xiaomi/ginkgo
rm -rf hardware/qcom-caf/sm8150/display
rm -rf hardware/qcom-caf/sm8150/audio
rm -rf hardware/qcom-caf/sm8150/media
git clone https://github.com/hpnightowl/hardware_qcom-caf_display-sm8150.git hardware/qcom-caf/sm8150/display
git clone https://github.com/owl-aosp/hardware_qcom-caf_sm8150_audio.git hardware/qcom-caf/sm8150/audio
git clone https://github.com/owl-aosp/hardware_qcom-caf_sm8150_media.git hardware/qcom-caf/sm8150/media
