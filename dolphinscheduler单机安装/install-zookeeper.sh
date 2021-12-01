#!/bin/bash

cd ~
checkup.sh

#------------------参数修改区域（开始）---------------------#
path_cun=/opt/software
path_an=/opt/module
node0=10.150.107.25
#------------------参数修改区域（结束）---------------------#

echo '开始进行安装前的检测'
val_path_cun=`ls /opt/software | grep zookeeper | wc -w`
    if [ $val_path_cun -eq 0 ];then
		echo '/opt/software路径中没有安装包，请将jdk的包放入/opt/software路径下'
    else
		echo '/opt/software路径中有安装包'
		val_path_an=`ls /opt/module | grep zookeeper | wc -w`
		Configuration_environment(){
		tar -zxf $path_cun/*zookeeper*.tar.gz -C $path_an
		if [ -z "`grep "ZOOKEEPER_HOME" /etc/profile.d/my_env.sh`" ];then
			echo '配置文件中不存在配置'
			cd $path_an/*zookeeper*
			echo '# ZOOKEEPER_HOME' >> /etc/profile.d/my_env.sh
			echo export ZOOKEEPER_HOME=`pwd` >> /etc/profile.d/my_env.sh
			echo 'export PATH=$PATH:$ZOOKEEPER_HOME/bin' >> /etc/profile.d/my_env.sh
			source /etc/profile.d/my_env.sh
		else
			echo '配置文件中存在配置'
			cd $path_an/*zookeeper*
			j=`pwd`
			if [ -z "`grep $j /etc/profile.d/my_env.sh`" ];then
				echo '组件的版本信息对不上'
				sed -i -r 's#(ZOOKEEPER_HOME=)(.*)#\1'$j'#g' /etc/profile.d/my_env.sh
				source /etc/profile.d/my_env.sh
			else
				echo '配置组件无需做操作'
			fi
		fi
		}
		
		if [ $val_path_an -eq 0 ];then
			echo '安装路径下没有组件'
			Configuration_environment
		else
			echo '安装路径下有组件'
			rm -rf $path_an/zookeeper*
			Configuration_environment
		fi
		
	fi

cd ~

# 配置文件
zoo(){
cd $ZOOKEEPER_HOME/conf
    cp zoo_sample.cfg zoo.cfg
	sed -i -r 's#(dataDir=)(.*)#\1'$ZOOKEEPER_HOME/zkData'#g' zoo.cfg
    echo dataLogDir=$ZOOKEEPER_HOME/logs >> zoo.cfg
    echo server.1=$node0:2888:3888 >> zoo.cfg
}
    cd $ZOOKEEPER_HOME
	mkdir zkData
	touch zkData/myid
	zoo
    echo 1 > $ZOOKEEPER_HOME/zkData/myid

source /etc/profile.d/my_env.sh
cd ~