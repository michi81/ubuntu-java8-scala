# Docker file for building an Ubuntu image with Oracle JDK 8 and Scala.
FROM ubuntu:latest

MAINTAINER Michele Prisco <michele.prisco@gmail.com>

ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.13

RUN apt-get update

# Installs Java 8
RUN apt-get -y install software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer oracle-java8-set-default libjansi-java

#Installs Maven
RUN apt-get install maven

# Installs Scala and SBT
RUN \
        DEBIAN_FRONTEND=noninteractive \
                cd /tmp && \
                wget -nv http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb && \
                wget -nv https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
                dpkg -i scala-*.deb && \
                dpkg -i sbt-$SBT_VERSION.deb && \
                rm -f scala-*.deb && \
                rm -f sbt-*.deb

# Updates package repo and clenup
RUN apt-get update && apt-get clean
