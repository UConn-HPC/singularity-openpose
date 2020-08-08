#-*- mode: rpm-spec; fill-column: 79 -*-
Bootstrap: docker
From: nvidia/cuda:10.2-cudnn7-devel-ubuntu16.04

%help
OpenPose: Real-time multi-person keypoint detection library for body,
face, hands, and foot estimation

%labels
maintainer Pariksheet Nanda <hpc@uconn.edu>
url https://github.com/UConn-HPC/singularity-openpose

# Prevent redownloading files.
%files
openpose /opt

%post
apt-get -y update
# Install dependencies.
build="
cmake
python3-dev
python3-pip
python3-setuptools
"
runtime="
libatlas-base-dev
libboost-all-dev
libgflags-dev
libgoogle-glog-dev
libhdf5-serial-dev
libleveldb-dev
liblmdb-dev
libopencv-dev
libprotobuf-dev
libsnappy-dev
protobuf-compiler
"
apt-get -qq install --no-install-recommends $build $runtime
# numpy 1.19 onwards no longer supports xenial's python 3.5
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade numpy==1.18.5 protobuf opencv-python
# Configure.
cd /opt/openpose
export WITH_CUDA=true WITH_PYTHON=true
test -d build || bash scripts/travis/configure.sh
# bash scripts/travis/run_make.sh
# bash scripts/travis/run_tests.sh
# apt-get -qq remove $build
