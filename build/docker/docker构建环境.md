# ����Docker�������뻷��
�鿴docker ����
sudo docker image ls
����docker����
sudo docker build -t sdk:v3 .
����docker����
docker run -it -v /home/steven/study2/dock_home:/home/share:rw sdk:v3
����һ������
docker start 2964129e362a
docker attach 2964129e362a


�ض���
make package/upointech/testapp/compile V=s > txt 2>&1

## define
https://www.jianshu.com/p/e2c78c8fb4a5
### ͨ��warning�����־���
$(eval $(call subdir,$(curdir)))
$(warning *****$(call subdir,$(curdir)))

