#!/usr/bin/env bash

cp comments_newlines.txt /tmp/comments_newlines.txt
cp comments.txt /tmp/comments.txt

cp name1.txt /tmp/name1.txt
cp name2.txt /tmp/name2.txt
cp name3.txt /tmp/name3.txt

mkdir /tmp/name1
mkdir /tmp/name2
mkdir /tmp/name3

cp name1.txt /tmp/name1/name1.txt
cp name2.txt /tmp/name2/name2.txt
cp name3.txt /tmp/name3/name3.txt

mkdir -p /tmp/class/file/hidden/here/
cp findme.txt /tmp/class/file/hidden/here/findme.txt

cp std_out_err.sh /tmp/std_out_err.sh

chmod 444 /tmp/comments_newlines.txt
chmod 444 /tmp/comments.txt
chmod 444 /tmp/name1.txt
chmod 444 /tmp/name2.txt
chmod 444 /tmp/name3.txt
chmod 444 /tmp/name1/name1.txt
chmod 444 /tmp/name2/name2.txt
chmod 444 /tmp/name3/name3.txt
chmod 444 /tmp/class/file/hidden/here/findme.txt
chmod 755 /tmp/std_out_err.sh

