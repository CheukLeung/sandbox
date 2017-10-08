FROM debian:stable
MAINTAINER Cheuk Wing Leung "cwleung@kth.se"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ftp.se.debian.org/debian stable main" > /etc/apt/sources.list
RUN echo "deb http://ftp.se.debian.org/debian stable-updates main" >> /etc/apt/sources.list
RUN echo "deb http://security.debian.org stable/updates main" >> /etc/apt/sources.list

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "apt-utils"]
RUN ["apt-get", "upgrade", "-y"]

RUN ["apt-get", "install", "-y", "sudo", "ssh"]
RUN echo "Europe/Stockholm" > /etc/timezone
RUN ["dpkg-reconfigure", "-f", "noninteractive", "tzdata"]

ADD start /usr/local/bin/
ADD profile /etc/skel/
ADD bashrc /etc/skel/

