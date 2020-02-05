#/bin/bash
#Auto add Linux user
#by authors Baif

RANDOMPASSWD=`date +%s | sha256sum | base64 | head -c 16 ; echo` 

read -p "请输入要创建的用户名:" username

if [ -z $username ]; then
        echo " {例如}:$0 logs"
        exit 0
else 
        PS3=您确认要创建用户${username}:
        select i in "Y" "N"
        do
                case $i in
                        Y)
                        groupadd ${username}
                        useradd -r -g ${username} ${username} 
                                if [ $? -ne 0 ];then
                                        echo "添加的用户已经存在，请检查"
                                        exit 0
                                else
                                        echo "建议用户${username}使用此随机密码:${RANDOMPASSWD}"
                                        passwd ${username}
                                fi
                                echo "用户${username}已经添加完毕"
                        ;;
                        N)
                        exit 
                        ;;
                esac
        break
        done    
fi  
