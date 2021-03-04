#
# Copyright (C) 2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_VENDOR:=ctc
PKG_NAME:=extccv3
PKG_VERSION:=1.1.05
#PKG_VERSION:=$(shell date +%Y.%m.%d)
PKG_DBUS_VERSION:=1
PKG_BASE_NAME:=$(PKG_NAME)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)


#allow some system calls
PKG_CAPABILITIES:=
#interfaces provided
PKG_SELF_INTERFACE:=
#interface requires
#PKG_USE_INTERFACE:=com.ctc.igd1.sdnfunc1.SDNInfo com.ctc.igd1.sdnfunc1.ONUInfo com.ctc.igd1.sdnfunc1.Ports com.ctc.cc1.MSG
#PKG_USE_INTERFACE:=
#interface vendor requires
PKG_USE_GWSYS_PATH:=/com/ctc/igd1/Config /com/ctc/igd1/Network /com/ctc/igd1/Info /com/ctc/igd1/Telecom
#interested events
#PKG_SUBSCRIBE_EVENT:=com.upointech.testapp1.event1
#data socket
PKG_SELF_UDS:=
#PKG_USE_UDS:=/uds/testapp/testapp.uds
#requires proc read/write permision
#PKG_NEED_ROOT:=1
#from 0 to 1024
PKG_CPU_SHARE:=128
#size can use K,M
PKG_MEMORY_LIMIT:=20M
#from 100 to 1000
#PKG_BLKIO_WEIGHT:=200
PKG_MAX_STORAGE_SIZE:=1M
PKG_PLUGIN_PRIORITY=high


include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

ifeq ($(CONFIG_TARGET_BOARD), "rtos44v2")
  CMAKE_OPTIONS += -DEXTCCV3_RTOS44V2_GRAMMER_CHECK=1
else
  CMAKE_OPTIONS += -DEXTCCV3_RTOS44V2_GRAMMER_CHECK=0
endif

define Package/$(PKG_NAME)
  SECTION:=base
  CATEGORY:=Smart Gateway Center
  TITLE:=extccv3 on Smart gateway application
  URL:=
  MAINTAINER:=Smart Gateway Center
  DEPENDS:=+glib2 +libcapi3 +libffi +libubox +jansson
  VERSION:=$(PKG_VERSION)
endef

define Package/$(PKG_NAME)/description
    $(PKG_BUILD_GITVER) $(PKG_BUILD_TIME)
endef

TARGET_LDFLAGS += -Wl,-rpath=/lib:$(STAGING_DIR)/usr/lib

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)
ifeq ($(CONFIG_TARGET_sd5117x),y)
	cp $(TOOLCHAIN_LIB_DIRS)/libdl.so.2 $(STAGING_DIR)/usr/lib
	cp $(TOOLCHAIN_LIB_DIRS)/libresolv.so.2 $(STAGING_DIR)/usr/lib
	cp $(TOOLCHAIN_LIB_DIRS)/libm.so.6 $(STAGING_DIR)/usr/lib
endif
ifdef CONFIG_TARGET_zx279127||CONFIG_TARGET_zx279128
	rm -rf $(STAGING_DIR)/usr/lib/libz.so.1.2.8
	cp $(TOOLCHAIN_LIB_DIRS)/libz.so.1.2.8 $(STAGING_DIR)/usr/lib
endif
endef

define Build/Clean
	rm -rf $(PKG_BUILD_DIR)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/opt/apps/$(PKG_NAME)/files
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/extcc $(1)/opt/apps/$(PKG_NAME)/files/$(PKG_NAME)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
