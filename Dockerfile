FROM ubuntu:18.04
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install scons gcc-msp430 python-pip sudo git

# The official package of gcc-arm-none-eabi by Ubuntu is kind of
# old. Use a package by "GCC Arm Embedded Maintainers" team
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa
RUN apt-get update
RUN apt-get -y install gcc-arm-embedded

RUN useradd user
RUN echo '%user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user
WORKDIR /home/user/openwsn-fw
