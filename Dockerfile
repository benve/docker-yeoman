# Yeoman with some generators and prerequisites
FROM ubuntu:trusty
MAINTAINER Jakub Głuszecki <jakub.gluszecki@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -yq update
# Fix the locale and install pre-requisites
# Install pre-requisites
RUN locale-gen en_US en_US.UTF-8; \
  dpkg-reconfigure locales; \
  apt-get -y -q install python-software-properties software-properties-common python g++ make git ruby-compass libfreetype6
# Install node.js, then npm install yo and the generators
RUN add-apt-repository ppa:chris-lea/node.js -y; \
  apt-get -y -q update; \
  DEBIAN_FRONTEND=noninteractive apt-get -y -q install nodejs; \
  npm install yo -g; \
  npm install -g generator-webapp generator-angular
# Add a yeoman user because grunt doesn't like being root
RUN adduser --disabled-password --gecos "" yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Expose the port
EXPOSE 9000
# Always run as the yeoman user
ENTRYPOINT ["/bin/su", "-", "yeoman"]
