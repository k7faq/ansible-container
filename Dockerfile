FROM alpine:3.7

ARG ANSIBLE_VERSION=2.7.7

ENV BUILD_PACKAGES \
  curl \
  g++ \
  libressl-dev \
  libffi-dev \
  openssh \
  openssl \
  python3-dev \
  py3-dateutil \
  py3-httplib2 \
  py3-jinja2 \
  py3-paramiko \
  py3-pip \
  py3-yaml \
  tar \
  sshpass \
  ca-certificates

ENV PYTHON_PACKAGES \
  PyMySQL \
  boto3 \
  python-keyczar \
  docker-py pyopenssl \
  ansible==${ANSIBLE_VERSION} 

RUN apk add --no-cache --virtual build-dependencies ${BUILD_PACKAGES} && \
  apk add --no-cache --update python3 && \
  pip3 install --upgrade pip && pip3 install ${PYTHON_PACKAGES} \
  && ln -sf /usr/bin/python3 /usr/bin/python && \
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
