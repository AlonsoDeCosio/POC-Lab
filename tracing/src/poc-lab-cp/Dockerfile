From tomcat:8.5.65-jdk8-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ./target/poc-lab-cp-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh","run"]