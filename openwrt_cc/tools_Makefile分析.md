# tools/Makefile

```
tools_enabled = $(foreach tool,$(sort $(tools-y) $(tools-)),$(if $(filter $(tool),$(tools-y)),y,n))
$(eval $(call stampfile,$(curdir),tools,install,,_$(subst $(space),,$(tools_enabled))))
$(eval $(call subdir,$(curdir)))
```
$(foreach var , list, text)

函数解释：把参数list中的单词逐一取出来放到var所指的变量中，然后再执行text所包含的表达式。每一次text会返回一个字符串，循环过程中，text所返回的每一个字符串以空格隔开。最后结束循环时，text所返回的每个字符串所组成的整个字符将会是foreach函数的返回值。
例子：
‘’’
names: = test main log caffe
files := $(foreach n , $(name), $(n).o )
‘’’
输出files的值为：“test.o main.o log.o caffe,o”


$(sort LIST) 
函数名称：排序函数—sort。 
函数功能：给字串“LIST”中的单词以首字母为准进行排序（升序），并取掉重复
的单词。 
返回值：空格分割的没有重复单词的字串。 
函数说明：两个功能，排序和去字串中的重复单词。可以单独使用其中一个功能。 
示例： 
$(sort foo bar lose foo) 
返回值为：“bar foo lose” 。
``` log 
$(sort $(tools-y) $(tools-))

tools-=gmp mpfr mpc libelf wrt350nv2-builder upslug2 upx qemu elftosb mtools dosfstools lzma-old squashfs b43-tools ppl cloog sparse

tools-y= m4 libtool autoconf automake flex bison pkg-config sed mklibs sstrip make-ext4fs e2fsprogs mtd-utils mkimage firmware-utils patch-image patch quilt yaffs2 flock padjffs2 mm-macros missing-macros xz cmake scons bc findutils gengetopt patchelf lzma squashfs4

sort=autoconf automake b43-tools bc bison cloog cmake dosfstools e2fsprogs elftosb findutils firmware-utils flex flock gengetopt gmp libelf libtool lzma lzma-old m4 make-ext4fs missing-macros mkimage mklibs mm-macros mpc mpfr mtd-utils mtools padjffs2 patch patch-image patchelf pkg-config ppl qemu quilt scons sed sparse squashfs squashfs4 sstrip upslug2 upx wrt350nv2-builder xz yaffs2

```

$(filter PATTERN…,TEXT) 
函数名称：过滤函数—filter。 
函数功能：过滤掉字串“TEXT”中所有符合模式“PATTERN”的单词，保留所
有符合此模式的单词。可以使用多个模式。模式中一般需要包含模式字
符“%”。存在多个模式时，模式表达式之间使用空格分割。 
返回值：空格分割的“TEXT”字串中所有符合模式“PATTERN”的字串。 
函数说明：“filter”函数可以用来去除一个变量中的某些字符串，我们下边的例子中
就是用到了此函数。 
示例： 
sources := foo.c bar.c baz.s ugh.h 
foo: $(sources) 
cc $(filter %.c %.s,$(sources)) -o foo 
 
使用“$(filter %.c %.s,$(sources))”的返回值给 cc 来编译生成目标“foo”，函数返回
值为“foo.c bar.c baz.s”

if 函数的语法是:
$(if <condition>,<then-part> )
或
$(if <condition>,<then-part>,<else-part> )
<condition>参数是if的表达式，如果其返回的为非空字符串，那么这个表达式就相当于返回真，于是，<then-part>会被计算，否则<else-part>会被计算

if函数的返回值是，
 如果<condition>为真（非空字符串），那个<then-part>会是整个函数的返回值，
 如果<condition>为假（空字符串），那么<else-part>会是整个函数的返回值，此时如果<else-part>没有被定义，那么，整个函数返回空字串。

SRC_DIR := src

if函数---设置默认值
如果变量SRC_DIR的值不为空,则将SRC_DIR指定的目录作为SUBDIR子目录;否则将/home/src作为子目录
SUBDIR += $(if $(SRC_DIR) $(SRC_DIR),/home/src)

all:
    @echo $(SUBDIR)


$(if $(filter $(tool),$(tools-y)),y,n)
如果变量$(tool) 符合$(tools-y) 返回y，否则n
tools_enabled = $(foreach tool,$(sort $(tools-y) $(tools-)),$(if $(filter $(tool),$(tools-y)),y,n))结果为
tools_enabled=y y n y y n y n y n y y y y y n n y y n y y y y y y n n y n y y y y y n n y y y n n y y n n n y y


```
$(eval $(call stampfile,$(curdir),tools,install,,_$(subst $(space),,$(tools_enabled))))
```
Makefile里的subst
用法是$(subst FROM,TO,TEXT),即将TEXT中的东西从FROM变为TO

Makefile中的字符串处理函数
格式：
    $(subst , , )
名称：字符串替换函数——subst。
功能：把字串;中的;字符串替换成;。
返回：函数返回被替换过后的字符串。

示例：
$(subst a,the,There is a big tree)，
把“There is a big tree”中的“a”替换成“the”，返回结果是“There is the big tree”。


call函数是唯一一个可以用来创建新的参数化的函数。你可以写一个非常复杂的表达式，这个表达式中，你可以定义许多参数，然后你可以用call函数来向这个表达式传递参数。其语法是：

$(call <expression>;,<parm1>;,<parm2>;,<parm3>;...)
当make执行这个函数时，<expression>;参数中的变量，如$(1)，$(2)，$(3)等，会被参数< parm1>;，<parm2>;，<parm3>;依次取代。而<expression>;的返回值就是 call函数的返回值。例如：

reverse =  $(1) $(2)

foo = $(call reverse,a,b)
那么，foo的值就是“a b”。当然，参数的次序是可以自定义的，不一定是顺序的，如：

reverse =  $(2) $(1)

foo = $(call reverse,a,b)
此时的foo的值就是“b a”

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

$(call stampfile,$(curdir),tools,install,,_$(subst $(space),,$(tools_enabled))) 执行结果
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

例如tools/Makefile中的call stampfile展开的变量
当这个文件的时间戳比tools目录下的某个文件旧时则会编译tools/install目标

```
$(eval $(call subdir,$(curdir)))
$(warning "**steven2***subdir=$(call subdir,$(curdir))")
```
tools/Makefile、target/Makefile、package/Makefile、toolchain/Makefile
这4个文件最后一行使用$(eval $(call subdir,$(curdir)))展开生成各个子目录的编译规则
以tools/Makefile中展开宏subdir为例
include/subdir.mk中定义的宏subdir
使用warning打印展开的结果
$(warning $(call subdir,$(curdir)))
make prepare -j1 V=s > log.txt 2>&1  日志结果如下
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
$(call HostBuild)展开的内容如下：（vi 中复制多行内容）
第一步： ：set num
第二步 ： 查看要复制的内容从num1 到num2 之间
第三步：:num1 ,num2  w! >> /你要保存的地址/文件名
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