# docs/Makefile

在Openwrt中docs目录下有工程编译、配置等相关的说明文档，我们可以把它们编译成一
个pdf等格式的文件，这样方面我们阅读。我的环境是Ubuntu，但是编译的时候，会报latex、
pdflatex、tex4ht等工具未找到，我们需要通过下面这两天命令安装这些工具：
apt-get install texlive
apt-get install tex4ht

然后编译就会生成openwrt.pdf、openwrt.html、openwrt.css这三个文件

make docs/compile -j1 V=s
