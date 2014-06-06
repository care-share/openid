TO BUILD:
        > mvn clean package

TO DEPLOY:
* Copy target\vha-rural-health-openid-connect-server.war to vha-rhex-oidc server
* On vha-rhex-oidc, execute the following:
        $ cd /usr/local/apache-tomcat-7.0.52/webapps
        $ sudo /etc/init.d/tomcat7 stop
* Copy vha-rural-health-openid-connect-server.war to 
  /usr/local/apache-tomcat-7.0.52/webapps
* Execute
        $ sudo /etc/init.d/tomcat7 start

TO EDIT THE DATABASE DIRECTLY:
Use this only if you have to. If you mess up the database file, you
mess up the database!

$ sudo /etc/init.d/tomcat7 stop
$ tail -f /usr/local/apache-tomcat-7.0.52/logs/catalina.out
        Until the server stops
$ vim  /usr/local/bin/development/oic_persistent_datastore/oic.script
$ sudo /etc/init.d/tomcat7 start
