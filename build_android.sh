#!/bin/bash

if [ -z "$ANDROID_NDK" ]; then
	echo "You must define ANDROID_NDK before starting."
	echo "They must point to your NDK directories.\n"
	exit 1
fi

SOURCE=`pwd`
PREFIX=$SOURCE/build/android

SYSROOT=$ANDROID_NDK/platforms/android-14/arch-arm
CROSS_PREFIX=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.7/prebuilt/linux-x86_64/bin/arm-linux-androideabi-

./configure  --prefix=$PREFIX \
  --cross-prefix=$CROSS_PREFIX \
  --enable-pic \
  --enable-static \
  --disable-cli \
  --disable-asm \
  --host=arm-linux \
  --sysroot=$SYSROOT

make clean
make -j4 install || exit 1

