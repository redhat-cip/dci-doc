FROM centos:7

LABEL name="DCI DOC" version="0.0.2"
LABEL maintainer="DCI Team <distributed-ci@redhat.com>"

WORKDIR /opt/dci-doc
COPY package.json /opt/dci-doc/

RUN yum install -y epel-release && \
    yum install -y nodejs npm && \
    yum clean all && \
    npm install && \
    npm cache clean

EXPOSE 4000

CMD ["npm", "run", "dev"]
