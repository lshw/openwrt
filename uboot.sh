#!/bin/bash
which swig
if [ $? != 0 ] ; then
	sudo apt install -y swig python3-pyelftools 
fi
make package/boot/uboot-rockchip/clean
make package/boot/uboot-rockchip/compile V=s -j$(nproc)
if [ $? != 0 ] ;then
	exit
fi
while [ 1 ]
do
lsusb |grep 2207:320c
if [ $? == 0 ] ;then
	break
fi
sleep 2
lsusb
done

sudo rkdeveloptool db rk3328_loader_v1.22.250.bin
sleep 2
sudo rkdeveloptool wl 0x40 staging_dir/target-aarch64_generic_musl/image/iflyhome-i01-rk3328-u-boot-rockchip.bin
