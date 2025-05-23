#FROM centos
#RUN yum update -y && \
#    yum install -y java
FROM adoptopenjdk/openjdk8

MAINTAINER fuxiuzhan@163.com

ADD ./target/*.jar /fxz/apps/

ADD ./src/main/resources/client.xml /data/appdatas/cat/client.xml

WORKDIR /fxz/apps/

ENV APPNAME="fuled-gateway"

ENV docker.env=true

ENV VERSION=0.0.1-SNAPSHOT

ENV PATH=$PATH:/fxz/apps/

ENV SERVER="inner.main.fuled.xyz:11800"

ENV JAVA_OPTS="-Denv=prd"

RUN curl -o apache-skywalking-apm-es7-8.3.0.tar.gz  http://nexus.fuled.xyz:8081/repository/fuled_oss/public/tools/skywalking/apache-skywalking-apm-es7-8.3.0.tar.gz && \
    gzip -d apache-skywalking-apm-es7-8.3.0.tar.gz && \
    tar -xvf apache-skywalking-apm-es7-8.3.0.tar && \
    rm  apache-skywalking-apm-es7-8.3.0.tar

ENV AGENTPATH="/fxz/apps/apache-skywalking-apm-bin-es7/agent/skywalking-agent.jar"

EXPOSE 8080/tcp

CMD ["mkdir /data"]

VOLUME ["/data"]

RUN echo "java -javaagent:$AGENTPATH -Dskywalking.agent.service_name=$APPNAME -Dagent.sample_n_per_3_secs=10000 -Dskywalking.collector.backend_service=$SERVER $JAVA_OPTS  -jar $APPNAME-$VERSION.jar" > start.sh

RUN chmod +x start.sh

ENTRYPOINT ["sh","-c","start.sh"]