FROM debian:jessie
MAINTAINER Nikita Tarasov <nikita@mygento.ru>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get upgrade -qqy

RUN apt-get install -qqy git apt-transport-https wget

RUN apt-get install -qqy rubygems puppet && gem install --no-rdoc --no-ri activesupport -v 4.2.5 && gem install librarian-puppet --no-rdoc --no-ri


# Run puppet
ONBUILD ADD Puppetfile /
ONBUILD RUN librarian-puppet install
ONBUILD ADD manifests/site.pp /
ONBUILD RUN mkdir -p /etc/puppet; touch /etc/puppet/hiera.yaml
ONBUILD RUN puppet apply --modulepath=/modules site.pp
ONBUILD RUN rm -fr /Puppetfile /modules /site.pp
