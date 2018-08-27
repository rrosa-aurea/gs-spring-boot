FROM maven:alpine

MAINTAINER Rafael C Rosa <rafael.rosa@aurea.com>

ENV LIBRE_OFFICE_PATH /usr/lib/libreoffice/program/soffice

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh libreoffice libreoffice-writer

COPY settings.xml /root/.m2/settings.xml

RUN mkdir /data
WORKDIR /data
CMD tail -f /dev/null
