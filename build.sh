#!/usr/bin/env bash

projects="dci-control-server dci-ui python-dciclient python-dciauth dci-downloader dci-openstack-agent dci-rhel-agent ansible-playbook-dci-beaker"
for project in ${projects}
do
    rm -rf ./src/${project}
    mkdir ./src/${project}
    cp ../${project}/README* ./src/${project}/
    cp -r ../${project}/docs/ ./src/${project}/docs/ 2>/dev/null
done

npm install
npm run build
