export TARGET=iphone:clang
GO_EASY_ON_ME = 1
ARCHS = armv7 arm64
DEBUG = 0
PACKAGE_VERSION = 1.0

THEOS=/opt/theos

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = JustinPlusPro
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_FRAMEWORKS = UIKit
$(TWEAK_NAME)_LDFLAGS += -F./
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
