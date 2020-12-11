# make menuconfig

当我们在顶层目录输入make menuconfig时，由于指定的目标为menuconfig，所以make会去寻找文件中menuconfig所在的地方，然后去执行其相应规则。我们可以看到，顶层的makefile中包含了$(TOPDIR)/include/debug.mk、$(TOPDIR)/include/depends.mk、$(TOPDIR)/include/toplevel.mk，menuconfig目标就在include/toplevel.mk中，下面是它的依赖和规则。其中$(TOPDIR)就是顶层目录，定义在主Makefile中TOPDIR:=${CURDIR}。

``` include/toplevel.mk
scripts/config/mconf:
        @$(_SINGLE)$(SUBMAKE) -s -C scripts/config all CC="$(HOSTCC_WRAPPER)"


menuconfig: scripts/config/mconf prepare-tmpinfo FORCE
        if [ \! -e .config -a -e $(HOME)/.openwrt/defconfig ]; then \
                cp $(HOME)/.openwrt/defconfig .config; \
        fi
        $< Config.in

```
HOSTCC_WRAPPER=cc

https://blog.csdn.net/chuanzhilong/article/details/52487717
https://blog.csdn.net/chuanzhilong/article/details/52426872


