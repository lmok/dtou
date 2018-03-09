# - prodish dfile
FROM ubuntu:14.04
MAINTAINER lmok

#
# - base layer
#
ENV HOME /opt
WORKDIR /opt

RUN apt-get update -qq
RUN apt-get install -y -qq git curl wget

# - install npm
RUN apt-get install -y -qq npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# - install bower
RUN npm install --global bower

#
# - DTOU layer
# - move prism to opt
#
COPY docker/build.json /opt/
COPY prism /opt/prism

