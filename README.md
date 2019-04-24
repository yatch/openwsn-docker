# Docker Image to Build OpenWSN Firmwares
An Ubuntu docker image with the following packages:

* `scons`
* `gcc-arm-none-eabi`
* `gcc-msp430`

## Prerequisite
* OpenWSN firmware source code, available at https://github.com/openwsn-berkeley/openwsn-fw
* Docker, see https://docs.docker.com/get-started/

## How to Build an OpenWSN firmware
Assuming...

* openwsn-fw is located at `/Users/foo/Work/openwsn-fw` on the local machine
* target board is `iot-lab_M3`
* target "project" is `oos_mercator`
* use `armgcc` for the toolchain

There is a single step:

``` shell
$ docker run --mount type=bind,source=/Users/foo/Work/openwsn-fw,destination=/home/user/openwsn-fw -ti yatch/openwsn-docker scons board=iot-lab_M3 toolchain=armgcc oos_mercator
```

You will have outputs like this:

``` shell
scons: Reading SConscript files ...

 ___                 _ _ _  ___  _ _
| . | ___  ___ ._ _ | | | |/ __>| \ |
| | || . \/ ._>| ' || | | |\__ \|   |
`___'|  _/\___.|_|_||__/_/ <___/|_\_|
     |_|                  openwsn.org

none
scons: done reading SConscript files.
scons: Building targets ...
Compiling          build/iot-lab_M3_armgcc/projects/common/03oos_mercator/03oos_mercator.o
Compiling          build/iot-lab_M3_armgcc/openstack/openstack.o
Compiling          build/iot-lab_M3_armgcc/openstack/02a-MAClow/topology.o
Compiling          build/iot-lab_M3_armgcc/openstack/02a-MAClow/IEEE802154.o
Compiling          build/iot-lab_M3_armgcc/openstack/02a-MAClow/IEEE802154E.o
...
arm-none-eabi-size --format=berkeley -x --totals build/iot-lab_M3_armgcc/projects/common/03oos_mercator_prog
   text    data     bss     dec     hex filename
 0x8230    0x1c  0xffe4   98864   18230 build/iot-lab_M3_armgcc/projects/common/03oos_mercator_prog
 0x8230    0x1c  0xffe4   98864   18230 (TOTALS)
arm-none-eabi-objcopy -O ihex build/iot-lab_M3_armgcc/projects/common/03oos_mercator_prog build/iot-lab_M3_armgcc/projects/common/03oos_mercator_prog.ihex
arm-none-eabi-objcopy -O binary build/iot-lab_M3_armgcc/projects/common/03oos_mercator_prog build/iot-lab_M3_armgcc/projects/common/03oos_mercator_prog.bin
scons: done building targets.
```

The firmware images are stored under `/Users/foo/Work/openwsn-fw/build/iot-lab_M3_armgcc/projects/common/` in this case.

Of course, you can run `scons` on `bash` in a container:

``` shell
$ docker run --mount type=bind,source=/Users/foo/Work/openwsn-fw,destination=/home/user/openwsn-fw -ti yatch/openwsn-docker bash
user@65b3b404d2eb:~/openwsn-fw$ scons board=telosb toolchain=mspgcc bsp_leds
```

If you want to clean the build directory, pass `--clean` option to `scons`:

``` shell
$ docker run --mount type=bind,source=/Users/foo/Work/openwsn-fw,destination=/home/user/openwsn-fw -ti yatch/openwsn-docker scons --clean board=iot-lab_M3 toolchain=armgcc oos_mercator
```

## How to Build your own Docker image
1. clone this repository
1. edit `Dockerfile` as you want
1. run `$ docker build .`
