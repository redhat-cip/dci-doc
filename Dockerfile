FROM centos:7

LABEL name="DCI DOC"
MAINTAINER DCI Team <distributed-ci@redhat.com>

RUN yum install -y epel-release && \
    yum install -y nodejs npm && \
    yum clean all

RUN mkdir -p /opt/dci-doc
WORKDIR /opt/dci-doc

COPY package.json /opt/dci-doc/
RUN npm install

EXPOSE 8000

CMD ["npm", "run", "dev"]
