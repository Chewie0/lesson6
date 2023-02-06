
RUN apt-get update \        
     apt-get install -y git
RUN mkdir /home/sampleTest \      
    cd /home/sampleTest \        
    git clone https://github.com/koddas/war-web-project.git
WORKDIR /home/sampleTest

FROM maven:3.6.1-jdk-8 as maven_builder

ENV HOME=/home/sampleTest
ADD pom.xml $HOME
RUN ["/usr/local/bin/mvn-entrypoint.sh", "mvn", "verify", "clean", "--fail-never"]

ADD . $HOME

RUN ["mvn","clean","install","-T","2C","-DskipTests=true"]
