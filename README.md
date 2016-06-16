# MITREid Connect Docker Image

This file contains instructions for running a [MITREid Connect server](https://github.com/mitreid-connect) using Docker. This Docker image will use the OpenID Connect Overlay to deploy a fully functional OpenID Connect server you can develop applications against.

## Prerequisites for Debian/Ubuntu

* [Maven installed](http://www.mkyong.com/maven/how-to-install-maven-in-ubuntu/)
* [Docker installed](http://docs.docker.com/installation/ubuntulinux/)
* [Docker Compose installed](https://docs.docker.com/compose/install/)
* Make sure that you do not have an application that is already running on port 8888

## Configuration

1. If it doesn't exist, copy the "`common.env.example`" file to create the "`common.env`" file
2. Edit the "`common.env`" file and change settings as desired

## Running

Using a terminal in the project's root directory:

1. Compile the server WAR file:

        $ mvn install

2. Build/rebuild the Docker image:

        $ docker-compose build

3. Start/restart the Docker container:

        $ docker-compose up -d

4. Check to make sure the container is running correctly:

        $ docker-compose ps

5. Check http://localhost:8888/ to see the web service

## Debugging

Here are various commands that may be useful for debugging.

* Build the Docker image named "openid":

        $ docker build -t openid .

* Run a new Docker container, in interactive mode, with a pseudo-tty, remove the container after exiting, forward port 8888 in the localhost to 8080 in the container, set the name to "openid-test", and use the "openid" image:

        $ docker run -i -t --rm --publish=8888:8080 --name=openid-test openid

* Check what ports have been forwarded for a running Docker container named "openid-test":

        $ docker port openid-test

* Get a bash shell for a running Docker container named "hapi-fhir-test":

        $ docker exec -i -t openid-test bash

## License

Copyright 2016 The MITRE Corporation, All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.