#!/bin/bash

cd ~
checkup.sh


# 设定安装路径和存放路径
path_cun=/opt/software
path_an=/opt/module
user=root
password=123456
cd ~

val_path_cun=`ls /opt/software | grep mysql | wc -w`
    if [ $val_path_cun -eq 0 ];then
	echo '存放路径中没有安装包'
	mv mysql-*-bundle.tar $path_cun
    else
	echo '存放路径中有安装包'
	fi
	
	mkdir $path_an/mysql
val_path_an=`ls /opt/module/mysql | grep mysql | wc -w`
    if [ $val_path_an -eq 0 ];then
       	echo '安装路径下没有组件'
		tar -xvf $path_cun/mysql-*-bundle.tar -C $path_an/mysql
    else
		echo '安装路径存在组件'
		rm -rf $path_an/mysql/*
		tar -xvf $path_cun/mysql-*-bundle.tar -C $path_an/mysql
	fi

# 检查是否安装了mariadb
	rpm -qa | grep mariadb
# 卸载mariadb数据库
	yum remove mariadb* -y
# 卸载mysql残存组件
	yum remove mysql-libs -y
	yum remove mysql-common -y
# 安装依赖
    rpm -ivh /opt/dependent/perl/*.rpm --nodeps --force
	rpm -ivh /opt/dependent/perl-Module-Install.noarch/*rpm --nodeps --force
# 安装mysql
	rpm -ivh $path_an/mysql/mysql-community-common-5.7.*.rpm --nodeps --force
	rpm -ivh $path_an/mysql/mysql-community-libs-5.7.*.rpm --nodeps --force
	rpm -ivh $path_an/mysql/mysql-community-libs-compat-5.7.*.rpm --nodeps --force
	rpm -ivh $path_an/mysql/mysql-community-client-5.7.*.rpm --nodeps --force
	rpm -ivh $path_an/mysql/mysql-community-server-5.7.*.rpm --nodeps --force
# 查看mysql的状态
	systemctl start mysqld.service
	systemctl status mysqld.service
	ps -ef | grep mysql
# 设置mysql开机启动
	systemctl enable mysqld.service		

# 修改mysql密码并配置所有用户访问
	sleep 2
	defaultmysqlpwd=`grep 'A temporary password' /var/log/mysqld.log | awk -F"root@localhost: " '{ print $2}'`
	/usr/bin/mysql --connect-expired-password -uroot -p${defaultmysqlpwd} <<EOF
set global validate_password_policy = 0;
set global validate_password_length=1;
SET PASSWORD = PASSWORD('123456');
grant all privileges on *.* to root@'%' identified by '123456';
EOF
	sleep 2
	systemctl restart mysqld.service
	echo -e "\033[35;5m mysql已经搭建好，所有用户可以进行远程来接，默认密码是123456 \033[0m"