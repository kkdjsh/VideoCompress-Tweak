THEOS_PACKAGE_SCHEME = rootless

export THEOS=/opt/theos

TARGET := iphone:clang:latest:14.0

ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = VideoCompress

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VideoCompressUnlock

VideoCompressUnlock_FILES = Tweak.x

VideoCompressUnlock_CFLAGS = -fobjc-arc

VideoCompressUnlock_FRAMEWORKS = UIKit Foundation

include $(THEOS)/makefiles/tweak.mk
