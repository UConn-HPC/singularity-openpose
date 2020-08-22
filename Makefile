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

$(TARGET) : $(SOURCE) openpose kitware.gpg
	$(TIME) sudo $(SINGULARITY) build $(BUILD_OPTS) $@ $< | tee $(BUILD_LOG)

openpose.simg : $(SOURCE) openpose kitware.gpg
	rm -f $@
	$(TIME) sudo $(SINGULARITY) build $@ $< | tee $(BUILD_LOG)

kitware.gpg :
	wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - > $@

# Use sed to patch CMakeLists.txt to workaround the newer checksum for
# downloading model files:
# https://github.com/CMU-Perceptual-Computing-Lab/openpose/pull/1675
openpose :
	git clone --branch v1.5.1 https://github.com/CMU-Perceptual-Computing-Lab/openpose
	git -C $@ submodule update --init --recursive --remote
	sed -z -i -E 's/(download_model[^\n]+\n\s*).{32}/\1d41d8cd98f00b204e9800998ecf8427e/g' $@/CMakeLists.txt
