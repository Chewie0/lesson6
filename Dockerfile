FROM maven:3.6.1-jdk-8 as maven_builder
WORKDIR /test
RUN apt-get install -y git
RUN git clone https://github.com/koddas/war-web-project.git /test
RUN mvn  -f pom.xml package
#RUN mkdir -p /test2
#WORKDIR /test/target
RUN ls
#RUN cp wwp-1.0.0.war ../../test2
#WORKDIR ../../test2

RUN ls
FROM tomcat:8.5.43-jdk8
EXPOSE 8080

COPY --from=maven_builder  /test/target/wwp-1.0.0.war /usr/local/tomcat/webapps
