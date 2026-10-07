#!/bin/bash
#debian13
sudo apt install -y libnl-3-dev libnl-genl-3-dev swig python3-pyelftools libgnutls28-dev python3-setuptools libpython3.13-dev
make defconfig
make -j1 V=s
if [ $? == 0 ] ; then
   scp bin/targets/rockchip/armv8/openwrt-25.12.5-rockchip-armv8-iflyhome_i01-squashfs-sysupgrade.img.gz root@www.bjlx.org.cn:/home/www/loongson/htdocs/
fi

