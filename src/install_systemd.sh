#!/usr/bin/env bash
set -e

echo "Install base requirements"
apt-get update
apt-get -yq install supervisor systemd systemd-sysv

rm -rf /lib/systemd/system/multi-user.target.wants/* ; \
rm -rf /etc/systemd/system/*.wants/* ; \
rm -rf /lib/systemd/system/local-fs.target.wants/* ; \
rm -rf /lib/systemd/system/sockets.target.wants/*udev* ; \
rm -rf /lib/systemd/system/sockets.target.wants/*initctl* ; \
rm -rf /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* ; \
rm -rf /lib/systemd/system/systemd-update-utmp*
