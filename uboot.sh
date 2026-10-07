#!/bin/bash
if ! [ "$1" ] ; then
  #debian13
sudo apt install -y swig python3-pyelftools libgnutls28-dev python3-setuptools libpython3.13-dev
make package/boot/uboot-rockchip/clean
make package/boot/uboot-rockchip/compile V=s -j$(nproc) 1>&2 |tee /tmp/uboot.log
 if [ $? != 0 ] ; then
   exit
 fi
fi
md5sum staging_dir/target-aarch64_generic_musl/image/iflyhome-i01-rk3328-u-boot-rockchip.bin
ssh root@192.168.12.35 md5sum /tmp/1/iflyhome-i01-rk3328-u-boot-rockchip.bin
scp staging_dir/target-aarch64_generic_musl/image/iflyhome-i01-rk3328-u-boot-rockchip.bin root@192.168.12.35:/tmp/1
ssh root@192.168.12.35  rkdeveloptool db `pwd`/rk3328_loader_v1.22.250.bin
sleep 2
ssh root@192.168.12.35  rkdeveloptool wl 0x40  /tmp/1/iflyhome-i01-rk3328-u-boot-rockchip.bin
ssh root@192.168.12.35  rkdeveloptool reboot
