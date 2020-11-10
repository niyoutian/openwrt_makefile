# profileselect.sh 分析
```javascript
root@bba7a897cddd:/home/share/test/openwrt_cc_v3.0# ./profileselect.sh 
Profile to choose: 
	01) confs/bcm6838.config
	02) confs/bcm6846.config
	03) confs/bcm6846x.config
	04) confs/bcm6848.config
	05) confs/bcm6856.config
	06) confs/bcm6858.config
	07) confs/bcm6878.config
	08) confs/ca8277.config
	09) confs/en7526.config
	10) confs/en7528.config
	11) confs/en7580.config
	12) confs/hi5662.config
	13) confs/hi5663.config
	14) confs/hi5681.config
	15) confs/hi5682.config
	16) confs/mt7526.config
	17) confs/mt7580.config
	18) confs/rtl9600c.config
	19) confs/rtl9600cfc.config
	20) confs/rtos44.config
	21) confs/rtos44v1.config
	22) confs/sd5117.config
	23) confs/sd5117x.config
	24) confs/sd5182.config
	25) confs/zx279127.config
	26) confs/zx279127s.config
	27) confs/zx279128.config
	28) confs/zx279128s.config
	29) confs/zx279131.config
	30) confs/zxic127v2.config
	31) confs/zxic128v2.config
	32) confs/zxic12x.config
	33) confs/zxic131.config

Please choose a profile [ 1 ~ 33 ]:
```

## 脚本分析
BASEDIR=$(pwd)
```
#!/bin/bash

BASEDIR=$(pwd)
echo "BASEDIR=$BASEDIR"
```
root@bba7a897cddd:/home/share/test/openwrt_cc_v3.0# ./profileselect.sh 
BASEDIR=/home/share/test/openwrt_cc_v3.0
BASEDIR指向SDK的根目录

``` bash
i=0
for confile in $(ls confs/*.config)
do
        let i+=1                     //第一次i = 1
        if [[ $i -le 9 ]]; then      //小于等于9 补0
        echo -e "\t0$i) $confile"    //补0
        else
        echo -e "\t$i) $confile"
        fi
done
```