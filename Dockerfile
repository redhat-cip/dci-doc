FROM registry.access.redhat.com/ubi8/python-36

LABEL name="DCI DOC"
LABEL version="0.2.0"
LABEL maintainer="DCI Team <distributed-ci@redhat.com>"

ENV LANG en_US.UTF-8

COPY . ./
RUN pip install -r requirements.txt

EXPOSE 4000

CMD ["mkdocs", "serve"]