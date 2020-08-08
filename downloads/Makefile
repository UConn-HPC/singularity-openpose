URLS = \
https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1604-10-1-local-10.1.105-418.39_1.0-1_amd64.deb \
https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.0.2.39/10.1_20200724/Ubuntu16_04-x64/libcudnn8_8.0.2.39-1+cuda10.1_amd64.deb \
https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.0.2.39/10.1_20200724/Ubuntu16_04-x64/libcudnn8-dev_8.0.2.39-1+cuda10.1_amd64.deb \
https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-ubuntu1604.pin
DOWNLOADS = $(notdir $(URLS))

$(DOWNLOADS) : % :
	echo $(URLS) | xargs wget -nc
