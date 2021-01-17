FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# set version label
LABEL maintainer="edifus"

# environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"
ENV HOME="/config"

# install software (deluge 1.3.15)
RUN \
 echo "**** add repositories ****" && \
 apt-get update && \
 apt-get install -y gnupg && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C5E6A5ED249AD24C && \
 echo "deb http://ppa.launchpad.net/deluge-team/ppa/ubuntu bionic main" >> \
	/etc/apt/sources.list.d/deluge.list && \
 echo "deb-src http://ppa.launchpad.net/deluge-team/ppa/ubuntu bionic main" >> \
	/etc/apt/sources.list.d/deluge.list && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	deluged \
	deluge-console \
	deluge-web \
	python-requests \
	p7zip-full \
	unrar \
	unzip && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
