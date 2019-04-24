FROM ubuntu:18.04
RUN apt-get update
RUN apt-get -y install scons gcc-arm-none-eabi gcc-msp430 python-pip sudo

RUN useradd user
RUN echo '%user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user
WORKDIR /home/user/openwsn-fw
