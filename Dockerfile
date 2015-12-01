# Docker file for building an Ubuntu image with Oracle JDK 8 and Scala.
FROM ubuntu:latest

MAINTAINER Michele Prisco <michele.prisco@gmail.com>

ENV SCALA_VERSION 2.11.7

RUN sudo apt-get update && sudo apt-get --assume-yes install software-properties-common python-software-properties
RUN sudo add-apt-repository ppa:webupd8team/java
RUN sudo apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN sudo apt-get --assume-yes install oracle-java8-installer oracle-java8-set-default
RUN \
	DEBIAN_FRONTEND=noninteractive \
		apt-get install -y --force-yes libjansi-java && \
	cd /tmp && \
	wget -nv http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb && \
	dpkg -i scala-*.deb && \
	rm -f scala-*.deb
RUN sudo apt-get --assume-yes install curl
RUN sudo apt-get update
RUN apt-get clean
