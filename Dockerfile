FROM maven:3.6.3-jdk-8 as maven_builder
WORKDIR /test
RUN apt-get install -y git
RUN git clone https://github.com/koddas/war-web-project.git /test
RUN mvn  -f pom.xml package
FROM tomcat:11.0.0-jdk17
EXPOSE 8080
COPY --from=maven_builder  /test/target/wwp-1.0.0.war /usr/local/tomcat/webapps
