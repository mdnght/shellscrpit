#!/bin/bash
#Author by BaiF
#启动银谷在线微服务容器

APPNAME=`find /code -type f -name "*.jar"`
DIRNAME=`basename ${APPNAME} .jar|awk -F "-exec" '{print $1}'`

/home/tomcat/jdk1.8/bin/java \
-Djava.awt.headless=true \
-Djava.net.preferIPv4Stack=true \
-server -Xms1024m -Xmx2048m -Xmn64m -Xss256k \
-XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC \
-XX:+CMSParallelRemarkEnabled -XX:LargePageSizeInBytes=128m \
-XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly \
-XX:CMSInitiatingOccupancyFraction=70 \
-jar ${APPNAME} \
--spring.cloud.config.uri=http://admin:dfyg8888@registry.yingujr.com/config \
--spring.profiles.active=prod \
--spring.cloud.config.label=master 
