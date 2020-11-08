export PATH="$HOME/proton/bin:$PATH"
SECONDS=0

mkdir -p out
make O=out ARCH=arm64 owl_defconfig
make -j16 O=out ARCH=arm64 CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- Image.gz-dtb

if [ -f "out/arch/arm64/boot/Image.gz-dtb" ]; then
git clone -q https://github.com/hpnightowl/AnyKernel3.git
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel3
rm -f *zip
cd AnyKernel3
zip -r9 "../RMXXXX-$(date '+%m%d')" * -x '*.git*' README.md *placeholder
cd ..
rm -rf AnyKernel3
echo -e "\nCompleted in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s) !"
else
echo -e "\nBuild failed!"
fi
