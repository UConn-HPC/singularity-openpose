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
kitware.gpg /etc/apt/trusted.gpg.d

%post
# pybind11 needs cmake 3.7 or later but xenial's cmake is 3.5.
echo 'deb https://apt.kitware.com/ubuntu/ xenial main' > /etc/apt/sources.list.d/cmake.list
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
test -d build || {
     mkdir -p build
     cd build
     cmake .. -DBUILD_PYTHON=On -DGPU_MODE=CUDA -DCUDA_ARCH=Manual -DCUDA_ARCH_BIN=52 -DUSE_CUDNN=On
     cd -
}
# Build.
cd build
make -j $(nproc)

%test
python3 -c 'import pyopenpose; print("pyopenpose:", dir(pyopenpose))'
python3 -c 'from caffe.proto import caffe_pb2; print("caffe_pb2:", dir(caffe_pb2))'

%environment
export PATH=/opt/openpose/build/examples/openpose:/opt/openpose/build/caffe/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PYTHONPATH=/opt/openpose/build/python/openpose:/opt/openpose/build/caffe/python
