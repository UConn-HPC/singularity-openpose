#-*- mode: rpm-spec; fill-column: 79 -*-
Bootstrap: debootstrap
OSVersion: xenial
MirrorURL: http://archive.ubuntu.com/ubuntu/

%help
OpenPose: Real-time multi-person keypoint detection library for body,
face, hands, and foot estimation

%labels
maintainer Pariksheet Nanda <hpc@uconn.edu>
url https://github.com/UConn-HPC/singularity-openpose

# Prevent redownloading files.
%files
v1.6.0.tar.gz /opt
cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb /opt
cudnn-8.0-linux-x64-v5.1.tgz /opt

%post
cd /opt
tardir=openpose-1.6.0
# Only expand the tarball once.
if ! [ -f $tardir/README.md ] ; then tar -xf v1.6.0.tar.gz ; fi
cd $tardir
for file in cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb cudnn-8.0-linux-x64-v5.1.tgz ; do ln -sf ../$file $file ; done
# Add missing universe source.
sed -i '/universe/!s/main/main universe/' /etc/apt/sources.list
apt-get -qq update
# Fix apt-utils configuration warnings.
apt-get -qq install apt-utils
# Install missing build dependencies.
DEBIAN_FRONTEND=noninteractive apt-get -qq install sudo cmake lsb-release keyboard-configuration python-numpy python3-numpy
# Disable wget commands because of our external downloads.
for file in install_cuda.sh install_cudnn.sh ; do sed -i -E '/^[^#]/s/(.*wget.*)/#\1/' scripts/ubuntu/$file ; done
# Set the same environmental variables as Travis CI.
export TRAVIS_OS_NAME=linux WTIH_CMAKE=false WITH_CUDA=true WITH_PYTHON=true
echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90-assume-yes
# numpy 1.19 onwards no longer supports xenial's python 3.5
sed -i '/pip /s/upgrade numpy /upgrade numpy==1.16.6 /' scripts/ubuntu/install_deps.sh
sed -i '/pip3/s/upgrade numpy /upgrade numpy==1.18.5 /' scripts/ubuntu/install_deps.sh
# Install all dependencies.
bash scripts/travis/install_deps_ubuntu.sh
bash scripts/travis/configure.sh
# bash scripts/travis/run_make.sh
# bash scripts/travis/run_tests.sh
rm -fv /opt/*.tar.gz  /opt/cuda*deb /opt/cudnn*.tgz /opt/openpose-1.6.0/cuda*deb /opt/openpose-1.6.0/cudnn*.tgz
