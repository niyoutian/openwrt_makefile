# make menuconfig

�������ڶ���Ŀ¼����make menuconfigʱ������ָ����Ŀ��Ϊmenuconfig������make��ȥѰ���ļ���menuconfig���ڵĵط���Ȼ��ȥִ������Ӧ�������ǿ��Կ����������makefile�а�����$(TOPDIR)/include/debug.mk��$(TOPDIR)/include/depends.mk��$(TOPDIR)/include/toplevel.mk��menuconfigĿ�����include/toplevel.mk�У����������������͹�������$(TOPDIR)���Ƕ���Ŀ¼����������Makefile��TOPDIR:=${CURDIR}��

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


