FROM debian:jessie
MAINTAINER Nikita Tarasov <nikita@mygento.ru>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get upgrade -qqy

RUN apt-get install -qqy git apt-transport-https wget

RUN apt-get install -qqy rubygems puppet && gem install --no-rdoc --no-ri activesupport -v 4.2.5 && gem install librarian-puppet --no-rdoc --no-ri

ADD hiera.yaml /etc/hiera.yaml

# Run puppet
ONBUILD ADD Puppetfile /
ONBUILD RUN librarian-puppet install
ONBUILD ADD module.yaml /etc/hiera/common.yaml
ONBUILD RUN puppet apply -e "hiera_include('classes')" --debug
