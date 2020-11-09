# 以最新的Ubuntu镜像为模板
FROM ubuntu:16.04

# 将本目录下的sources.list作为容器的一个文件
ADD sources.list /root/sources.list
# 使用阿里Ubuntu源，更新快
RUN mv /etc/apt/sources.list  /etc/apt/sources.list_bak
RUN cp /root/sources.list  /etc/apt/sources.list

RUN apt-get update
# 安装vim
RUN apt-get install -y vim
# ./framework_v3.0_R4001.sh 缺少bzip2
RUN apt-get install -y bzip2
# Make时出错，缺少以下库
RUN apt-get install -y make
RUN apt-get install -y gcc
RUN apt-get install -y g++
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y openssl
RUN apt-get install -y libssl-dev
RUN apt-get install -y patch
RUN apt-get install -y gawk
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get install -y python2.7
RUN apt-get install -y subversion subversion-tools
RUN apt-get install -y git git-core
#bash: xzcat: command not found
RUN apt-get install -y xz-utils
# ERROR: CONFIG_SOFT_FLOAT is enabled but the external toolchain does not support it
RUN apt-get install -y lib32z1-dev
# error while loading shared libraries: libacl.so.1: cannot open shared object file: No such file or directory
#ln -sf `which tar` /home/share/openwrt_cc_v3.0/staging_dir/host/bin/tar

#*** You must have either have gettext support in your C library, or use the
#*** GNU gettext library. (http://www.gnu.org/software/gettext/gettext.html)
RUN apt-get install -y gettext

RUN mkdir -p /home/toolchain

#zx279127  zx279128
COPY toolchain/zx279127_279128_toolchain.tgz /home/toolchain
RUN cd /home/toolchain/;tar zxf zx279127_279128_toolchain.tgz
RUN mkdir -p /opt/zte/cross_compiler
RUN mv /home/toolchain/opt/zte/cross_compiler/arm-linux-uclibcgnueabi /opt/zte/cross_compiler/



COPY hello.txt /home
