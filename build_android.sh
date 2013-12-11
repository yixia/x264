#!/bin/bash

if [ -z "$ANDROID_NDK" ]; then
	echo "You must define ANDROID_NDK before starting."
	echo "They must point to your NDK directories.\n"
	exit 1
fi

SOURCE=`pwd`
PREFIX=$SOURCE/build/android

SYSROOT=$ANDROID_NDK/platforms/android-14/arch-arm
CROSS_PREFIX=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=neon -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__"
EXTRA_LDFLAGS="-nostdlib"

./configure  --prefix=$PREFIX \
	--cross-prefix=$CROSS_PREFIX \
	--extra-cflags="$EXTRA_CFLAGS" \
	--extra-ldflags="$EXTRA_LDFLAGS" \
	--enable-pic \
	--enable-static \
	--enable-strip \
	--disable-cli \
	--host=arm-linux \
	--sysroot=$SYSROOT

make clean
make STRIP= -j4 install || exit 1

