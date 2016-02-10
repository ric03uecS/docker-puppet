FROM debian:jessie
MAINTAINER Nikita Tarasov <nikita@mygento.ru>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get upgrade -qqy

RUN apt-get install -qqy puppet git librarian-puppet
