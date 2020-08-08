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
openpose /opt
downloads /opt
downloads/cuda-ubuntu1604.pin /etc/apt/preferences.d

%post
# Add sources.
sed -i '/universe/!s/main/main universe/' /etc/apt/sources.list
dpkg --status cuda || {
     dpkg --install /opt/downloads/cuda*.deb
     apt-key add /var/cuda-repo-*/7fa2af80.pub
     cd /etc/apt/preferences.d
     mv cuda-ubuntu1604.pin cuda-pin-600
     cd -
}
apt-get -y update
# Fix apt-utils configuration warnings.
apt-get -qq install apt-utils
# Install build dependencies.
apt-get -qq install cmake
#cuda
# dpkg -i /opt/downloads/libcudnn8_*.deb /opt/downloads/libcudnn8-dev_*.deb
# dpkg -i /opt/downloads/libcudnn8_*.deb
# dpkg -i /opt/downloads/libcudnn8-dev_*.deb
# # Install remaining dependencies.  numpy 1.19 onwards no longer supports xenial's python 3.5
# pushd /opt/openpose
# sed -i '/pip /s/upgrade numpy /upgrade numpy==1.16.6 /' scripts/ubuntu/install_deps.sh
# sed -i '/pip3/s/upgrade numpy /upgrade numpy==1.18.5 /' scripts/ubuntu/install_deps.sh
# echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90-assume-yes
# bash scripts/ubuntu/install_deps.sh
# export WITH_CUDA=true WITH_PYTHON=true
# bash scripts/travis/configure.sh
# bash scripts/travis/run_make.sh
# bash scripts/travis/run_tests.sh
rm -rf /opt/downloads
dpkg --remove cuda-repo-ubuntu1604-10-1-local-10.1.105-418.39
