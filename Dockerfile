# Android Dockerfile
FROM ubuntu:14.04

MAINTAINER ChenHai "chenhai@fun.tv"

# Sets language to UTF8 : this works in pretty much all case
ENV LANG en_US.UTF-8

# Add 32bit support in 64bit system
RUN dpkg --add-architecture i386

# Language support
RUN apt-get update && apt-get install -y \
	language-pack-zh-hant language-pack-zh-hans \
	language-pack-en

# change timezone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

# Installing packages
RUN apt-get update && apt-get install -y \
	lib32z1 \
	lib32ncurses5 \
	lib32bz2-1.0 

# add nameserver
RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf 

# android build env
RUN apt-get update && apt-get install -y \
	gcc-multilib g++-multilib build-essential \
	git-core gnupg bison flex gperf pngcrush bc zip curl lzop \
	libxml2 libxml2-utils xsltproc squashfs-tools \
	libesd0-dev libsdl1.2-dev libwxgtk2.8-dev libswitch-perl \
	libssl1.0.0 libssl-dev lib32readline-gplv2-dev libncurses5-dev

# use bash instead of dash
RUN ln -sf /bin/bash /bin/sh
# Set env
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh

RUN useradd chenhai -u 1000 -s /bin/bash 
RUN echo "chenhai:abc.123" | chpasswd
RUN echo "chenhai ALL=(ALL) ALL" >> /etc/sudoers
#change root passwd
RUN echo "root:abc.123" | chpasswd
USER chenhai
WORKDIR /home/chenhai
#

