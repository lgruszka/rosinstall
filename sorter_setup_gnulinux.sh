#!/bin/bash

export LANG=en_US.UTF-8
export LANGUAGE=en
export OROCOS_TARGET=gnulinux

wget https://raw.githubusercontent.com/lgruszka/rosinstall/master/sorter_gnulinux.rosinstall -O /tmp/sorter_gnulinux.rosinstall

if [ ! -d $1 ]; then
  mkdir $1
fi

cd $1
wstool init
wstool merge /tmp/sorter_gnulinux.rosinstall
wstool update
cd underlay_isolated
catkin_make_isolated --install -DENABLE_CORBA=ON -DCORBA_IMPLEMENTATION=OMNIORB -DCMAKE_BUILD_TYPE=RelWithDebInfo
source install_isolated/setup.bash
cd ../underlay
catkin_make -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCATKIN_ENABLE_TESTING=OFF
source devel/setup.bash
