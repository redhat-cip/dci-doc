FROM registry.access.redhat.com/ubi9/ubi-minimal

LABEL name="DCI DOC"
LABEL version="0.3.0"
LABEL maintainer="DCI Team <distributed-ci@redhat.com>"

RUN microdnf -y upgrade && \
    microdnf -y install nginx && \
    microdnf clean all

COPY ./docs /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
