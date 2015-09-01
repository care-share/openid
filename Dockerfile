FROM tomcat:7-jre8

# Install Ruby (needed to run Tiller)
RUN apt-get -y update && apt-get -y install ruby

# Install Tiller for configuration management
RUN gem install tiller

# Copy the WAR file we want to run
COPY vha-rural-health-openid-connect/target/vha-rural-health-openid-connect-server.war /tmp/openid.war

# Manually deploy the WAR file, since we need to overwrite some of its config files
RUN \
    rm -rf ${CATALINA_HOME}/webapps/ROOT/ &&\
    unzip /tmp/openid.war -d ${CATALINA_HOME}/webapps/ROOT/ &&\
    rm /tmp/openid.war

# Copy Tiller templates and configuration
ADD docker/tiller /etc/tiller

# Copy TLS keystore, if any
COPY docker/tls ${CATALINA_HOME}/conf/tls

# Run Tiller
CMD ["/usr/local/bin/tiller" , "-v"]

