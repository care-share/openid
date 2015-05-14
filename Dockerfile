FROM tomcat:7-jre8
WORKDIR ~/
#COPY ~/.m2/settings.xml .m2/settings.xml
COPY ./ ./openid-overlay

RUN apt-get update && apt-get install -y maven2
WORKDIR openid-overlay
RUN mvn clean package
COPY vha-rural-health-openid-connect/target/vha-rural-health-openid-connect-server.war ${CATALINE_HOME}/webapps
