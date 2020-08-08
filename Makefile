SINGULARITY = /opt/singularity-2.6/bin/singularity
# SINGULARITY = /opt/singularity-2.6/bin/singularity
TIME = command time -v
SHELL = /bin/bash
SOURCE = Singularity
TARGET = openpose.simg
URLS = \
https://github.com/CMU-Perceptual-Computing-Lab/openpose/archive/v1.6.0.tar.gz \
https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb \
http://developer.download.nvidia.com/compute/redist/cudnn/v5.1/cudnn-8.0-linux-x64-v5.1.tgz
DOWNLOADS = $(notdir $(URLS))
BUILD_LOG = build.log

$(TARGET) : $(SOURCE) $(DOWNLOADS)
	$(TIME) sudo $(SINGULARITY) build $@ $< | tee $(BUILD_LOG)

$(DOWNLOADS) : % :
	echo $(URLS) | xargs wget -nc
