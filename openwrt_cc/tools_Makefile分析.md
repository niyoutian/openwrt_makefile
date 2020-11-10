# tools/Makefile

```
tools_enabled = $(foreach tool,$(sort $(tools-y) $(tools-)),$(if $(filter $(tool),$(tools-y)),y,n))
$(eval $(call stampfile,$(curdir),tools,install,,_$(subst $(space),,$(tools_enabled))))
$(eval $(call subdir,$(curdir)))
```
$(foreach var , list, text)

�������ͣ��Ѳ���list�еĵ�����һȡ�����ŵ�var��ָ�ı����У�Ȼ����ִ��text�������ı��ʽ��ÿһ��text�᷵��һ���ַ�����ѭ�������У�text�����ص�ÿһ���ַ����Կո������������ѭ��ʱ��text�����ص�ÿ���ַ�������ɵ������ַ�������foreach�����ķ���ֵ��
���ӣ�
������
names: = test main log caffe
files := $(foreach n , $(name), $(n).o )
������
���files��ֵΪ����test.o main.o log.o caffe,o��


$(sort LIST) 
�������ƣ���������sort�� 
�������ܣ����ִ���LIST���еĵ���������ĸΪ׼�����������򣩣���ȡ���ظ�
�ĵ��ʡ� 
����ֵ���ո�ָ��û���ظ����ʵ��ִ��� 
����˵�����������ܣ������ȥ�ִ��е��ظ����ʡ����Ե���ʹ������һ�����ܡ� 
ʾ���� 
$(sort foo bar lose foo) 
����ֵΪ����bar foo lose�� ��
``` log 
$(sort $(tools-y) $(tools-))

tools-=gmp mpfr mpc libelf wrt350nv2-builder upslug2 upx qemu elftosb mtools dosfstools lzma-old squashfs b43-tools ppl cloog sparse

tools-y= m4 libtool autoconf automake flex bison pkg-config sed mklibs sstrip make-ext4fs e2fsprogs mtd-utils mkimage firmware-utils patch-image patch quilt yaffs2 flock padjffs2 mm-macros missing-macros xz cmake scons bc findutils gengetopt patchelf lzma squashfs4

sort=autoconf automake b43-tools bc bison cloog cmake dosfstools e2fsprogs elftosb findutils firmware-utils flex flock gengetopt gmp libelf libtool lzma lzma-old m4 make-ext4fs missing-macros mkimage mklibs mm-macros mpc mpfr mtd-utils mtools padjffs2 patch patch-image patchelf pkg-config ppl qemu quilt scons sed sparse squashfs squashfs4 sstrip upslug2 upx wrt350nv2-builder xz yaffs2

```

$(filter PATTERN��,TEXT) 
�������ƣ����˺�����filter�� 
�������ܣ����˵��ִ���TEXT�������з���ģʽ��PATTERN���ĵ��ʣ�������
�з��ϴ�ģʽ�ĵ��ʡ�����ʹ�ö��ģʽ��ģʽ��һ����Ҫ����ģʽ��
����%�������ڶ��ģʽʱ��ģʽ���ʽ֮��ʹ�ÿո�ָ 
����ֵ���ո�ָ�ġ�TEXT���ִ������з���ģʽ��PATTERN�����ִ��� 
����˵������filter��������������ȥ��һ�������е�ĳЩ�ַ����������±ߵ�������
�����õ��˴˺����� 
ʾ���� 
sources := foo.c bar.c baz.s ugh.h 
foo: $(sources) 
cc $(filter %.c %.s,$(sources)) -o foo 
 
ʹ�á�$(filter %.c %.s,$(sources))���ķ���ֵ�� cc ����������Ŀ�ꡰfoo������������
ֵΪ��foo.c bar.c baz.s��

if �������﷨��:
$(if <condition>,<then-part> )
��
$(if <condition>,<then-part>,<else-part> )
<condition>������if�ı��ʽ������䷵�ص�Ϊ�ǿ��ַ�������ô������ʽ���൱�ڷ����棬���ǣ�<then-part>�ᱻ���㣬����<else-part>�ᱻ����

if�����ķ���ֵ�ǣ�
 ���<condition>Ϊ�棨�ǿ��ַ��������Ǹ�<then-part>�������������ķ���ֵ��
 ���<condition>Ϊ�٣����ַ���������ô<else-part>�������������ķ���ֵ����ʱ���<else-part>û�б����壬��ô�������������ؿ��ִ���

SRC_DIR := src

if����---����Ĭ��ֵ
�������SRC_DIR��ֵ��Ϊ��,��SRC_DIRָ����Ŀ¼��ΪSUBDIR��Ŀ¼;����/home/src��Ϊ��Ŀ¼
SUBDIR += $(if $(SRC_DIR) $(SRC_DIR),/home/src)

all:
    @echo $(SUBDIR)


$(if $(filter $(tool),$(tools-y)),y,n)
�������$(tool) ����$(tools-y) ����y������n
tools_enabled = $(foreach tool,$(sort $(tools-y) $(tools-)),$(if $(filter $(tool),$(tools-y)),y,n))���Ϊ
tools_enabled=y y n y y n y n y n y y y y y n n y y n y y y y y y n n y n y y y y y n n y y y n n y y n n n y y


```
$(eval $(call stampfile,$(curdir),tools,install,,_$(subst $(space),,$(tools_enabled))))
```
Makefile���subst
�÷���$(subst FROM,TO,TEXT),����TEXT�еĶ�����FROM��ΪTO

Makefile�е��ַ���������
��ʽ��
    $(subst , , )
���ƣ��ַ����滻��������subst��
���ܣ����ִ�;�е�;�ַ����滻��;��
���أ��������ر��滻������ַ�����

ʾ����
$(subst a,the,There is a big tree)��
�ѡ�There is a big tree���еġ�a���滻�ɡ�the�������ؽ���ǡ�There is the big tree����


call������Ψһһ���������������µĲ������ĺ����������дһ���ǳ����ӵı��ʽ��������ʽ�У�����Զ�����������Ȼ���������call��������������ʽ���ݲ��������﷨�ǣ�

$(call <expression>;,<parm1>;,<parm2>;,<parm3>;...)
��makeִ���������ʱ��<expression>;�����еı�������$(1)��$(2)��$(3)�ȣ��ᱻ����< parm1>;��<parm2>;��<parm3>;����ȡ������<expression>;�ķ���ֵ���� call�����ķ���ֵ�����磺

reverse =  $(1) $(2)

foo = $(call reverse,a,b)
��ô��foo��ֵ���ǡ�a b������Ȼ�������Ĵ����ǿ����Զ���ģ���һ����˳��ģ��磺

reverse =  $(2) $(1)

foo = $(call reverse,a,b)
��ʱ��foo��ֵ���ǡ�b a��

``` include/subdir.mk   stampfile
# Parameters: <subdir> <name> <target> <depends> <config options> <stampfile location>
define stampfile
  $(1)/stamp-$(3):=$(if $(6),$(6),$(STAGING_DIR))/stamp/.$(2)_$(3)$(5)
  $$($(1)/stamp-$(3)): $(TMP_DIR)/.build $(4)
        @+$(SCRIPT_DIR)/timestamp.pl -n $$($(1)/stamp-$(3)) $(1) $(4) || \
                $(MAKE) $(if $(QUIET),--no-print-directory) $$($(1)/flags-$(3)) $(1)/$(3)
        @mkdir -p $$$$(dirname $$($(1)/stamp-$(3)))
        @touch $$($(1)/stamp-$(3))

  $$(if $(call debug,$(1),v),,.SILENT: $$($(1)/stamp-$(3)))

  .PRECIOUS: $$($(1)/stamp-$(3)) # work around a make bug

  $(1)//clean:=$(1)/stamp-$(3)/clean
  $(1)/stamp-$(3)/clean: FORCE
        @rm -f $$($(1)/stamp-$(3))

endef
```

$(call stampfile,$(curdir),tools,install,,_$(subst $(space),,$(tools_enabled))) ִ�н��
tools/stamp-install:=/home/share/openwrt_cc_v3.0/staging_dir/target-arm-27912x-linux-uclibc/stamp/.tools_install_yynyynynynyyyyynnyynyyyyyynnynyyyyynnyyynnyynnnyy
  $(tools/stamp-install): /home/share/openwrt_cc_v3.0/tmp/.build 
	@+/home/share/openwrt_cc_v3.0/scripts/timestamp.pl -n $(tools/stamp-install) tools  || make  $(tools/flags-install) tools/install
	@mkdir -p $$(dirname $(tools/stamp-install))
	@touch $(tools/stamp-install)

  $(if ,,.SILENT: $(tools/stamp-install))

  .PRECIOUS: $(tools/stamp-install) # work around a make bug

  tools//clean:=tools/stamp-install/clean
  tools/stamp-install/clean: FORCE
	@rm -f $(tools/stamp-install)

����tools/Makefile�е�call stampfileչ���ı���
������ļ���ʱ�����toolsĿ¼�µ�ĳ���ļ���ʱ������tools/installĿ��

```
$(eval $(call subdir,$(curdir)))
$(warning "**steven2***subdir=$(call subdir,$(curdir))")
```
tools/Makefile��target/Makefile��package/Makefile��toolchain/Makefile
��4���ļ����һ��ʹ��$(eval $(call subdir,$(curdir)))չ�����ɸ�����Ŀ¼�ı������
��tools/Makefile��չ����subdirΪ��
include/subdir.mk�ж���ĺ�subdir
ʹ��warning��ӡչ���Ľ��
$(warning $(call subdir,$(curdir)))
make prepare -j1 V=s > log.txt 2>&1  ��־�������
```
tools/Makefile:130: "**steven2***subdir=
	tools/m4/clean:  tools/stamp-install/clean
						@+ $(SUBMAKE) -r -C tools/m4 clean BUILD_VARIANT=""
        # aliases
      tools/m4/install:  tools/m4/compile
                        @+ $(SUBMAKE) -r -C tools/m4 install BUILD_VARIANT=""

tools/install: .config prereq tools/m4/install tools/libtool/install tools/autoconf/install tools/automake/install tools/flex/install tools/bison/install tools/pkg-config/install tools/sed/install tools/mklibs/install tools/sstrip/install tools/make-ext4fs/install tools/e2fsprogs/install tools/mtd-utils/install tools/mkimage/install tools/firmware-utils/install tools/patch-image/install tools/patch/install tools/quilt/install tools/yaffs2/install tools/flock/install tools/padjffs2/install tools/mm-macros/install tools/missing-macros/install tools/xz/install tools/cmake/install tools/scons/install tools/bc/install tools/findutils/install tools/gengetopt/install tools/patchelf/install tools/lzma/install tools/squashfs4/install

tools/configure: .config prereq tools/m4/configure tools/libtool/configure tools/autoconf/configure tools/automake/configure tools/flex/configure tools/bison/configure tools/pkg-      config/configure tools/sed/configure tools/mklibs/configure tools/sstrip/configure tools/make-ext4fs/configure tools/e2fsprogs/configure tools/mtd-utils/configure tools/mkimage/conf      igure tools/firmware-utils/configure tools/patch-image/configure tools/patch/configure tools/quilt/configure tools/yaffs2/configure tools/flock/configure tools/padjffs2/configure to      ols/mm-macros/configure tools/missing-macros/configure tools/xz/configure tools/cmake/configure tools/scons/configure tools/bc/configure tools/findutils/configure tools/gengetopt/co      nfigure tools/patchelf/configure tools/lzma/configure tools/squashfs4/configure
```

# tools/m4/Makefile
```
include $(TOPDIR)/rules.mk

PKG_NAME:=m4
PKG_VERSION:=1.4.17

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@GNU/$(PKG_NAME)
PKG_MD5SUM:=12a3c829301a4fd6586a57d3fcf196dc
PKG_CAT:=xzcat

HOST_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/host-build.mk

HOST_CONFIGURE_VARS += gl_cv_func_strstr_linear=no

define Host/Clean
        -$(MAKE) -C $(HOST_BUILD_DIR) uninstall
        $(call Host/Clean/Default)
endef
$(warning "m4_HostBuild=$(call HostBuild)")
$(eval $(call HostBuild))
```
$(call HostBuild)չ�����������£���vi �и��ƶ������ݣ�
��һ���� ��set num
�ڶ��� �� �鿴Ҫ���Ƶ����ݴ�num1 ��num2 ֮��
��������:num1 ,num2  w! >> /��Ҫ����ĵ�ַ/�ļ���
ok
```
    ifeq (@GNU/m4,)
      $(error Download/default is missing the URL field.)
    endif
   
    ifeq (m4-1.4.17.tar.xz,)
      $(error Download/default is missing the FILE field.)
    endif
  

  
    /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305: /home/share/openwrt_cc_v3.0/dl/m4-1.4.17.tar.xz
  
  download: /home/share/openwrt_cc_v3.0/dl/m4-1.4.17.tar.xz

  /home/share/openwrt_cc_v3.0/dl/m4-1.4.17.tar.xz:
	mkdir -p /home/share/openwrt_cc_v3.0/dl
		/home/share/openwrt_cc_v3.0/scripts/download.pl "/home/share/openwrt_cc_v3.0/dl" "m4-1.4.17.tar.xz" "12a3c829301a4fd6586a57d3fcf196dc" "@GNU/m4"

        .PRECIOUS: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305
  .SILENT: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check

  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check

ifneq (/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305,)
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check::
	 { [ -f "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check.1" ] && mv "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check.1"; /home/share/openwrt_cc_v3.0/scripts/timestamp.pl -x "*/.svn*" -x ".*" -x "*:*" -x "*\!*" -x "* *" -x "*\#*" -x "*/.*_check" -x "*/.*.swp"  -n /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305 /home/share/openwrt_cc_v3.0/tools/m4  && {  touch -r "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305" "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check"; } } || {  touch "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check"; }
	
else
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305_check::
	
	
endif

      .PRECIOUS: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built
  .SILENT: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check

  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check

ifneq (/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built,)
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check::
	 { [ -f "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check.1" ] && mv "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check.1"; /home/share/openwrt_cc_v3.0/scripts/timestamp.pl -x "*/.svn*" -x ".*" -x "*:*" -x "*\!*" -x "* *" -x "*\#*" -x "*/.*_check" -x "*/.*.swp"  -n /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17 && {  touch -r "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built" "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check"; } } || {  touch "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check"; }
	
else
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built_check::
	
	
endif


  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305:
	@-rm -rf /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17
	@mkdir -p /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17
	
	  	. /home/share/openwrt_cc_v3.0/include/shell.sh; xzcat /home/share/openwrt_cc_v3.0/dl/m4-1.4.17.tar.xz | /bin/tar -C /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.. -xf - 
		
		@if [ -d "./patches" ] && [ "$$(ls ./patches | wc -l)" -gt 0 ]; then export PATCH="patch"; if [ -s "./patches/series" ]; then sed -e s,\\\#.*,, ./patches/series | grep -E \[a-zA-Z0-9\] | xargs -n1 /home/share/openwrt_cc_v3.0/scripts/patch-kernel.sh "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17" "./patches"; else /home/share/openwrt_cc_v3.0/scripts/patch-kernel.sh "/home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17" "./patches"; fi; fi
	
	
	touch $@

    /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured : export ACLOCAL_INCLUDE=$(foreach p,$(wildcard $(STAGING_DIR_HOST)/share/aclocal $(STAGING_DIR_HOST)/share/aclocal-*),-I $(p))
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured : export STAGING_PREFIX=$(STAGING_DIR_HOST)
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured : export PKG_CONFIG_PATH=$(STAGING_DIR_HOST)/lib/pkgconfig
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured : export PKG_CONFIG_LIBDIR=$(STAGING_DIR_HOST)/lib/pkgconfig
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured : export CCACHE_DIR:=/home/share/openwrt_cc_v3.0/staging_dir/host/ccache
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305
	
	  	(cd /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/; if [ -x configure ]; then cp -fpR /home/share/openwrt_cc_v3.0/scripts/config.{guess,sub} /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17// &&  bash ./configure CC="gcc" CFLAGS="-O2 -I/home/share/openwrt_cc_v3.0/staging_dir/host/include -I/home/share/openwrt_cc_v3.0/staging_dir/host/usr/include" CPPFLAGS="-I/home/share/openwrt_cc_v3.0/staging_dir/host/include -I/home/share/openwrt_cc_v3.0/staging_dir/host/usr/include" LDFLAGS="-L/home/share/openwrt_cc_v3.0/staging_dir/host/lib -L/home/share/openwrt_cc_v3.0/staging_dir/host/usr/lib" SHELL="/usr/bin/env bash" gl_cv_func_strstr_linear=no --target=x86_64-linux-gnu --host=x86_64-linux-gnu --build=x86_64-linux-gnu --program-prefix="" --program-suffix="" --prefix=/home/share/openwrt_cc_v3.0/staging_dir/host --exec-prefix=/home/share/openwrt_cc_v3.0/staging_dir/host --sysconfdir=/home/share/openwrt_cc_v3.0/staging_dir/host/etc --localstatedir=/home/share/openwrt_cc_v3.0/staging_dir/host/var --sbindir=/home/share/openwrt_cc_v3.0/staging_dir/host/bin ; fi )
	
	touch $@

    /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built : export ACLOCAL_INCLUDE=$(foreach p,$(wildcard $(STAGING_DIR_HOST)/share/aclocal $(STAGING_DIR_HOST)/share/aclocal-*),-I $(p))
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built : export STAGING_PREFIX=$(STAGING_DIR_HOST)
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built : export PKG_CONFIG_PATH=$(STAGING_DIR_HOST)/lib/pkgconfig
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built : export PKG_CONFIG_LIBDIR=$(STAGING_DIR_HOST)/lib/pkgconfig
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built : export CCACHE_DIR:=/home/share/openwrt_cc_v3.0/staging_dir/host/ccache
  /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured
		
		  	+make   -C /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17  
		
		touch $@

  /home/share/openwrt_cc_v3.0/staging_dir/host/stamp/.m4_installed: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built 
		  	export MAKEFLAGS= ;make -C /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17 install
		
		mkdir -p $(shell dirname $@)
		touch /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built
		touch $@

  ifndef STAMP_BUILT
    prepare: host-prepare
    compile: host-compile
    install: host-install
    clean: host-clean
    update: host-update
    refresh: host-refresh
  endif

  host-prepare: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.preparedb8caa877ca409d1a9f588639de054305
  host-configure: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.configured
  host-compile: /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built 
  host-install: /home/share/openwrt_cc_v3.0/staging_dir/host/stamp/.m4_installed
  host-clean: FORCE
		-make -C /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17 uninstall
	
	
	rm -rf /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17 /home/share/openwrt_cc_v3.0/staging_dir/host/stamp/.m4_installed /home/share/openwrt_cc_v3.0/build_dir/host/m4-1.4.17/.built

```