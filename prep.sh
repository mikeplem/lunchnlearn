#!/usr/bin/env bash

cp name1.txt /tmp/name1.txt
cp name2.txt /tmp/name2.txt
cp name3.txt /tmp/name3.txt

mkdir /tmp/name1
mkdir /tmp/name2
mkdir /tmp/name3

cp name1.txt /tmp/name1/name1.txt
cp name2.txt /tmp/name2/name2.txt
cp name3.txt /tmp/name3/name3.txt

rm name1.txt
rm name2.txt
rm name3.txt

mkdir -p /tmp/class/file/hidden/here/
cp findme.txt /tmp/class/file/hidden/here/findme.txt
rm findme.txt
