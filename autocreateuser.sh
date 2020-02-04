#/bin/bash
#Auto add Linux user
#by authors Baif

read -p "请输入要创建的用户名:"  username

if [ -z $username ]; then
        echo " {例如}:$0 logs"
        exit 0
else 
        groupadd ${username}
        useradd ${username} -g ${username} 
                if [ $? -ne 0 ];then
                        echo "添加的用户已经存在，请检查"
                        exit 0
                else
                        passwd ${username}
                fi
        echo "用户${username}已经添加完毕"
fi 
