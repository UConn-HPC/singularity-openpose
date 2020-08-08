SINGULARITY = /opt/singularity-3.6/bin/singularity
TIME = command time -v
SHELL = /bin/bash
SOURCE = Singularity
TARGET = sandbox
BUILD_LOG = build.log
BUILD_OPTS = --sandbox
ifeq ($(TARGET),$(wildcard $(TARGET)))
BUILD_OPTS += --update
endif

$(TARGET) : $(SOURCE) downloads openpose
	$(TIME) sudo $(SINGULARITY) build $(BUILD_OPTS) $@ $< | tee $(BUILD_LOG)

openpose :
	git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose
	git -C $@ submodule update --init --recursive --remote
