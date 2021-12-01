#!/bin/bash

cd ~
checkup.sh

# 检测/opt/software路径下是否存在jdk安装包
val_path_cun=`ls /opt/software | grep jdk | wc -w`
if [ $val_path_cun -eq 0 ];then
	echo '/opt/software路径中没有安装包，请将jdk的包放入/opt/software路径下'
else
	echo '/opt/software路径中有安装包'
	# 检测/opt/module路径下是否存在jdk解压文件
	val_path_an=`ls /opt/module | grep jdk | wc -w`
		Configuration_environment(){
		tar -zxf /opt/software/jdk*.tar.gz -C /opt/module
		if [ -z "`grep "JAVA_HOME" /etc/profile.d/my_env.sh`" ];then
			echo '配置文件中不存在配置'
			cd /opt/module/jdk*
			echo '# JAVA_HOME' >> /etc/profile.d/my_env.sh
			echo export JAVA_HOME=`pwd` >> /etc/profile.d/my_env.sh
			echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile.d/my_env.sh
			source /etc/profile.d/my_env.sh
		else
			echo '配置文件中存在配置'
			cd /opt/module/jdk*
			j=`pwd`
			if [ -z "`grep $j /etc/profile.d/my_env.sh`" ];then
				echo '组件的版本信息对不上'
				sed -i -r 's#(JAVA_HOME)(.*)#\1'$j'#g' /etc/profile.d/my_env.sh
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
		ssh $x rm -rf /opt/module/jdk*
		Configuration_environment
	fi
fi

cd ~


