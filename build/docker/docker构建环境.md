# 基于Docker构建编译环境
查看docker 镜像
sudo docker image ls
编译docker镜像
sudo docker build -t sdk:v3 .
启动docker镜像
docker run -it -v /home/steven/study2/dock_home:/home/share:rw sdk:v3

sudo docker run -it -p 2222:22 -v /home/steven/study2/work_sdk:/home/share:rw sdk:v4

启动一个容器
docker start 2964129e362a 
docker attach 2964129e362a

docker container rm $(sudo docker ps -a -q)
docker images rm $(sudo docker images -q)


重定向：
make package/upointech/testapp/compile V=s > txt 2>&1

## define
https://www.jianshu.com/p/e2c78c8fb4a5
### 通过warning添加日志输出
$(eval $(call subdir,$(curdir)))
$(warning "*****$(call subdir,$(curdir))")

