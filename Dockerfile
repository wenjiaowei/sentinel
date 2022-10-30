FROM openjdk:8-jdk

# 环境变量
ENV LC_ALL=zh_CN.utf8
ENV LANG=zh_CN.utf8
ENV LANGUAGE=zh_CN.utf8
ENV SERVER_HOST localhost

# 开放端口
EXPOSE 8080

# 指定工作目录
WORKDIR /app

# 将当前目录下的jar包复制道镜像中的/app目录下
COPY sentinel-dashboard.jar .

# 时间同步设置
# 设置权限 chown 用户:所在组 文件目录 0表示root用户所在的组标识；1001是指定了一个用户标识
# chmod 读取权限 r = 4,写入权限 w = 2,执行权限 x = 1
# 3个数字分别代表 拥有者，组用户，其他用户的权限
# 775中的第一个7表示4+2+1 表示拥有者拥有读写执行权限
# 第二个7当前用户所在组中的用户拥有者拥有读写执行权限
# 第三个5表示其他用户有读和执行的权限 没有写的权限

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone \ 
 && chown 1001:0 -R /app \
 && chmod 775 -R /app

# java启动jar包
ENTRYPOINT ["java","-Dfile.encoding=UTF8","-Dsun.jnu.encoding=UTF8","-jar","sentinel-dashboard.jar"]
