FROM ubuntu:16.04
MAINTAINER Roman Romanov <rroma.dev@gmail.com>

ARG HOST_UID
ARG HOST_GID
ARG HOST_USERNAME=develop
ARG HOST_GROUPNAME=develop

RUN groupadd ${HOST_GROUPNAME} -g ${HOST_GID}
RUN adduser --uid ${HOST_UID} --gid ${HOST_GID} ${HOST_USERNAME} --disabled-password --gecos ''

RUN apt-get update
RUN apt-get -y install sudo
RUN sudo adduser ${HOST_USERNAME} sudo
RUN echo "${HOST_USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV HOME /home/${HOST_USERNAME}
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install software-properties-common python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get -y install php7.1 php7.1-cli php7.1-common php7.1-curl php7.1-gd php7.1-json php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-intl php7.1-zip
RUN apt-get -y install git
RUN apt-get -y install unzip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

RUN apt-get update
RUN apt-get -y install nodejs
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN apt-get -y install npm
RUN npm install -g grunt-cli
RUN npm install -g bower

RUN chown ${HOST_USERNAME} ${HOME} -R

EXPOSE 80

USER develop

ADD run.sh /run.sh
RUN sudo chmod 0755 /run.sh
CMD ["bash", "run.sh"]