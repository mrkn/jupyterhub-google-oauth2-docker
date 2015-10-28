FROM ubuntu:14.04
MAINTAINER Kenta Murata <mrkn@mrkn.jp>

RUN apt-get update && \
    apt-get install -y --force-yes \
      git-core \
      nodejs-legacy \
      npm \
      python3.4 \
      python3.4-dev \
      python3-pip
RUN pip3 install -U pip
RUN npm install -g \
      configurable-http-proxy

# JupyterHub

RUN pip3 install -U jupyterhub

# Dockerspawner

WORKDIR /tmp/
ADD dockerspawner /tmp/dockerspawner
WORKDIR /tmp/dockerspawner

RUN pip3 install -r requirements.txt
RUN python3 setup.py install

#

EXPOSE 8000
