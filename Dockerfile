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

RUN pip3 install -U \
      jupyterhub \
      jupyter-client

# Dockerspawner

WORKDIR /tmp/dockerspawner
RUN pip3 install -e 'git+https://github.com/jupyter/dockerspawner.git#egg=dockerspawner'

# traitlets

WORKDIR /tmp/traitlets
RUN pip3 install -e 'git+https://github.com/ipython/traitlets.git#egg=traitlets'

# jh-google-oauthenticator

WORKDIR /tmp/jh-google-oauthenticator
RUN pip3 install -e 'git+https://github.com/mrkn/jh-google-oauthenticator@traitlets#egg=oauthenticator'

# Configuration

RUN mkdir -p /etc/jupyterhub/
COPY jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py
RUN mkdir -p /etc/jupyterhub/ssl && chmod 440 /etc/jupyterhub/ssl

# Entry point

COPY start_jupyterhub /usr/local/bin/

EXPOSE 8000
WORKDIR /
