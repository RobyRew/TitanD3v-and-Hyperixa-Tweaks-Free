#!/bin/sh

#packages
echo building package list
dpkg-scanpackages -m ./debs > Packages

echo bzip compressing
bzip2 -5fkv Packages > Packages.bz2

echo xz compressing
xz -5fkev Packages > Packages.xz

echo lzma compressing
xz -5fkev --format=lzma Packages > Packages.lzma