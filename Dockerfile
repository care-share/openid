FROM tomcat:7-jre8

# Install Tiller for configuration management
RUN apt-get -y update && apt-get -y install ruby && gem install tiller

# Copy the WAR file we want to run
COPY vha-rural-health-openid-connect/target/vha-rural-health-openid-connect-server.war ${CATALINA_HOME}/webapps/openid.war

# Manually deploy the WAR file, since we need to overwrite some of its config files
RUN cd ${CATALINA_HOME}/webapps/ && unzip openid.war -d ./openid/ && rm openid.war

# Copy Tiller templates and configuration
ADD docker/tiller /etc/tiller

# Run Tiller
CMD ["/usr/local/bin/tiller" , "-v"]

