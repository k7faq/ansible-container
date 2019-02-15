FROM alpine:3.7

ARG ANSIBLE_VERSION=2.7.7

ENV BUILD_PACKAGES \
  curl \
  g++ \
  python3-dev \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-jinja2 \
  py-paramiko \
  py-pip \
  py-setuptools \
  py-yaml \
  tar \
  ca-certificates

RUN apk add --no-cache --virtual build-dependencies ${BUILD_PACKAGES} && \
    apk add --no-cache --update python3 && \  
    pip3 install --upgrade pip && pip3 install python-keyczar docker-py && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/ansible /ansible && \
    echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library

WORKDIR /ansible/playbooks

