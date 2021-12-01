#!/bin/bash

echo '检测环境变量文件是否创建'
if [ -a /etc/profile.d/my_env.sh ];then
    echo '环境变量文件存在!'
else
    echo '环境变量文件不存在，开始创建'
    touch /etc/profile.d/my_env.sh
fi

echo '检测组件安装包存放路径是否存在'
if [ -a /opt/software ];then
    echo '安装包存放路径文件夹存在！'
else
	cd /opt
    echo '存放路径不存在，创建安装包的存放路径'
    mkdir software
fi

echo '检测组件安装包安装路径是否存在'
if [ -a /opt/module ];then
    echo '安装包安装路径文件夹存在！'
else
    cd /opt
    echo '安装路径不存在，创建安装包的安装路径'
    mkdir module
fi

echo '检测第三方依赖存放路径是否存在'
if [ -a /opt/dependent ];then
    echo '第三方依赖存放路径文件夹存在！'
else
    cd /opt
    echo '存放路径不存在，创建第三方依赖的存放路径'
    mkdir dependent
fi

cd ~