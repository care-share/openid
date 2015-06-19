FROM tomcat:7-jre8
COPY server.xml conf/
COPY vha-rural-health-openid-connect/target/vha-rural-health-openid-connect-server.war ${CATALINA_HOME}/webapps/openid.war
