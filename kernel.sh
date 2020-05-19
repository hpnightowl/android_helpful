#!/bin/bash
echo "======================"
echo "Welcome To Owls Building"
echo "======================"
make clean && make mrproper
mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=~/owls/cc/clang-r383902/bin
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=~/owls/gcc_64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=~/owls/gcc_32/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=~/owls/cc/clang-r383902/lib64:$LD_LIBRARY_PATH
make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out vendor/trinket-perf_defconfig
echo "==================="
echo "Making Owls Nest"
echo "==================="
make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out -j4
