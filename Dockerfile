FROM centos:7 
RUN echo "root:root" | chpasswd
RUN yum -y install net-tools

# install java
ADD http://dl.mycat.io/jdk-8u20-linux-x64.tar.gz /usr/local/
RUN cd /usr/local && tar -zxvf jdk-8u20-linux-x64.tar.gz && ls -lna && rm jdk-8u20-linux-x64.tar.gz

ENV JAVA_HOME /usr/local/jdk1.8.0_20
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin

#install mycat
ADD http://dl.mycat.io/1.6.5/Mycat-server-1.6.5-release-20180122220033-linux.tar.gz /usr/local
RUN cd /usr/local && tar -zxvf Mycat-server-1.6.5-release-20180122220033-linux.tar.gz && ls -lna && rm Mycat-server-1.6.5-release-20180122220033-linux.tar.gz

#download mycat-ef-proxy
#RUN mkdir -p /usr/local/proxy
#ADD https://github.com/LonghronShen/mycat-docker/releases/download/1.6/MyCat-Entity-Framework-Core-Proxy.1.0.0-alpha2-netcore100.tar.gz /usr/local/proxy
#RUN cd /usr/local/proxy && tar -zxvf MyCat-Entity-Framework-Core-Proxy.1.0.0-alpha2-netcore100.tar.gz && ls -lna && sed -i -e 's#C:\\\\mycat#/usr/local/mycat#g' config.json

VOLUME /usr/local/mycat/conf

EXPOSE 8066 9066
#EXPOSE 7066

CMD /usr/local/mycat/bin/mycat console
