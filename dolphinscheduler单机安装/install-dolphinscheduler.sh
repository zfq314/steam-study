#!/bin/bash

cd ~
checkup.sh

# 参考网址：https://www.shangmayuan.com/a/19094d4b83b941d1adca034d.html
# 设定安装路径,配置路径和存放路径
path_cun=/opt/software
path_conf=/opt/module
path_an=/opt/module/install


echo '开始进行安装前的检测'
val_path_cun=`ls /opt/software | grep dolphinscheduler | wc -w`
    if [ $val_path_cun -eq 0 ];then
		echo '/opt/software中没有安装包，请将安装包放入指定的路径下'
    else
		echo '/opt/software中有安装包。'
		rm -rf $path_conf/*dolphinscheduler*
		tar -zxf $path_cun/*dolphinscheduler*.tar.gz -C $path_conf
	fi
mkdir /opt/module/install
val_path_cun=`ls /opt/module/install | grep dolphinscheduler | wc -w`
    if [ $val_path_cun -eq 0 ];then
		echo '/opt/software中没有安装包，请将安装包放入指定的路径下'
    else
		echo '/opt/software中有安装包。'
		rm -rf $path_an
	fi	


datasource(){
# 添加mysql依赖
cd /opt/module/*dolphinscheduler*
val_path_cun=`ls lib | grep mysql-connector-java | wc -w`
    if [ $val_path_cun -eq 0 ];then
		echo '没有依赖'
		cp /opt/software/mysql-connector-java*.jar lib/
    else
	    echo '有依赖。'
	fi
# 创建存储dolphinscheduler元数据的数据库
mysql -uroot -p123456 -e "drop database IF EXISTS dolphinscheduler;create database IF NOT EXISTS dolphinscheduler DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci"
# 配置dolphinscheduler到mysql的配置文件
cd /opt/module/*dolphinscheduler*/conf
cp datasource.properties datasource.properties_bak
cat <<EOF> datasource.properties
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.url=jdbc:mysql://10.150.107.25:3306/dolphinscheduler?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true
spring.datasource.username=root
spring.datasource.password=123456
EOF
# 执行ds自带的脚本
cd /opt/module/*dolphinscheduler*/script
sh create-dolphinscheduler.sh
}

dolphinscheduler_env(){
cd /opt/module/*dolphinscheduler*/conf/env
cp dolphinscheduler_env.sh dolphinscheduler_env.sh_bak

cat <<EOF> dolphinscheduler_env.sh
export JAVA_HOME=$JAVA_HOME

EOF
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> dolphinscheduler_env.sh

rm -rf /usr/bin/java
ln -s $JAVA_HOME/bin/java /usr/bin/java
}

install_config(){
cd /opt/module/*dolphinscheduler*/conf/config
cp install_config.conf install_config.conf_bak

cat <<EOF> install_config.conf

# postgresql or mysql
dbtype="mysql"

# db config
# db address and port
dbhost="10.150.107.25:3306"

# db username
username="root"

# database name
dbname="dolphinscheduler"

# db passwprd
password="123456"

# zk cluster
zkQuorum="10.150.107.25:2181"

# Note: the target installation path for dolphinscheduler, please not config as the same as the current path (pwd)
installPath="/opt/module/install/dolphinscheduler"

# deployment user
deployUser="root"


# alert config
# mail server host
mailServerHost="smtp.qq.com"

# mail server port
# note: Different protocols and encryption methods correspond to different ports, when SSL/TLS is enabled, make sure the port is correct.
mailServerPort="25"

# sender
mailSender="1343521755@qq.com"

# user
mailUser="1343521755@qq.com"

# sender password
# note: The mail.passwd is email service authorization code, not the email login password.
mailPassword="ydnvktaadszrijfg"

# TLS mail protocol support
starttlsEnable="true"

# SSL mail protocol support
# only one of TLS and SSL can be in the true state.
sslEnable="false"

#note: sslTrust is the same as mailServerHost
sslTrust="smtp.qq.com"

# user data local directory path, please make sure the directory exists and have read write permissions
dataBasedirPath="/tmp/dolphinscheduler"

# resource storage type: HDFS, S3, NONE
resourceStorageType="HDFS"

# resource store on HDFS/S3 path, resource file will store to this hadoop hdfs path, self configuration, please make sure the directory exists on hdfs and have read write permissions. "/dolphinscheduler" is recommended
resourceUploadPath="/dolphinscheduler"

# if resourceStorageType is HDFS，defaultFS write namenode address，HA you need to put core-site.xml and hdfs-site.xml in the conf directory.
# if S3，write S3 address，HA，for example ：s3a://dolphinscheduler，
# Note，s3 be sure to create the root directory /dolphinscheduler
defaultFS="hdfs://10.150.107.26:9000"

# if resourceStorageType is S3, the following three configuration is required, otherwise please ignore
s3Endpoint="http://192.168.xx.xx:9010"
s3AccessKey="xxxxxxxxxx"
s3SecretKey="xxxxxxxxxx"

# resourcemanager port, the default value is 8088 if not specified
resourceManagerHttpAddressPort="8088"

# if resourcemanager HA is enabled, please set the HA IPs; if resourcemanager is single, keep this value empty
# yarnHaIps="192.168.xx.xx,192.168.xx.xx"

# if resourcemanager HA is enabled or not use resourcemanager, please keep the default value; If resourcemanager is single, you only need to replace ds1 to actual resourcemanager hostname
singleYarnIp="10.150.107.26"

# who have permissions to create directory under HDFS/S3 root path
# Note: if kerberos is enabled, please config hdfsRootUser=
hdfsRootUser="root"

# kerberos config
# whether kerberos starts, if kerberos starts, following four items need to config, otherwise please ignore
kerberosStartUp="false"
# kdc krb5 config file path
krb5ConfPath="$installPath/conf/krb5.conf"
# keytab username
keytabUserName="hdfs-mycluster@ESZ.COM"
# username keytab path
keytabPath="$installPath/conf/hdfs.headless.keytab"
# kerberos expire time, the unit is hour
kerberosExpireTime="2"

# api server port
apiServerPort="12345"


# install hosts
# Note: install the scheduled hostname list. If it is pseudo-distributed, just write a pseudo-distributed hostname
ips="10.150.107.25"

# ssh port, default 22
# Note: if ssh port is not default, modify here
sshPort="22"

# run master machine
# Note: list of hosts hostname for deploying master
masters="10.150.107.25"

# run worker machine
# note: need to write the worker group name of each worker, the default value is "default"
workers="10.150.107.25:default"

# run alert machine
# note: list of machine hostnames for deploying alert server
alertServer="10.150.107.25"

# run api machine
# note: list of machine hostnames for deploying api server
apiServers="10.150.107.25"

EOF

# 将要连接的大数据中hadoop下面的配置文件复制过来
cd /opt/module/*dolphinscheduler*
cp /opt/software/core-site.xml ./conf/
cp /opt/software/hdfs-site.xml ./conf/
}


datasource
dolphinscheduler_env
install_config
cd /opt/module/*dolphinscheduler*
sh install.sh

echo '网站：http://10.150.107.25:12345/dolphinscheduler'
echo '用户：admin'
echo '密码：dolphinscheduler123'
cd ~