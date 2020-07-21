#!/bin/bash
# Desc: 将需要的日志上传到oss：lily-log-backup

# JVM虚拟机运行日志的保存，即supervisor项目日志

# 规定ossutil 工具安装在/home/lily.admin/ossutil64

HOSTNAME=`cat /etc/hostname`

YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date -d last-day +%d)

PATH=/home/lily.admin

# 日志存储目录
lilyclasslog_log_dir=/var/log/classonline
lilybeservice_log_dir=/var/log/be_classonline

# 存储的日志移动到临时目录进行处理，处理后上传到对应的oss path，上传后删除该目录下日志
log2oss_dir=/tmp/log2oss
lilyclasslog_tmp_dir=${log2oss_dir}/classonlinelog
lilybeservice_tmp_dir=${log2oss_dir}/lilybeservice
[ -d ${lilyclasslog_tmp_dir} ] || /usr/bin/mkdir -p ${lilyclasslog_tmp_dir}
[ -d ${lilybeservice_tmp_dir} ] || /usr/bin/mkdir -p ${lilybeservice_tmp_dir}

# classonline日志重新命名并上传oss
/usr/bin/cp ${lilyclasslog_log_dir}/classonline*.${YEAR}-${MONTH}-${DAY}.zip ${lilyclasslog_tmp_dir}
cd ${lilyclasslog_tmp_dir}
/usr/bin/rename 'classonline' "${HOSTNAME}_classonline" *.zip
${PATH}/ossutil64 cp ${lilyclasslog_tmp_dir} --include "*classonline*.${YEAR}-${MONTH}-${DAY}.zip" -r oss://lily-log-backup/service/${YEAR}/${MONTH}/${DAY}/ -f
/usr/bin/rm -rf /tmp/log2oss/classonlinelog

# be_service日志重新命名并上传oss
/usr/bin/cp ${lilybeservice_log_dir}/classonline*.${YEAR}-${MONTH}-${DAY}.zip ${lilybeservice_tmp_dir}
cd ${lilybeservice_tmp_dir}
/usr/bin/rename 'classonline' "${HOSTNAME}_be_service" *.zip
${PATH}/ossutil64 cp ${lilybeservice_tmp_dir} --include "*be_service*.${YEAR}-${MONTH}-${DAY}.zip" -r oss://lily-log-backup/be_service/${YEAR}/${MONTH}/${DAY}/ -f
/usr/bin/rm -rf /tmp/l2oss/lilybeservice
