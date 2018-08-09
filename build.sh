#!/usr/bin/env bash

projects="dci-ui python-dciclient python-dciauth dci-control-server dci-ansible dci-ansible-agent dci-dev-env dci-rhel-agent"
for project in ${projects}
do
    pushd /tmp
    rm -rf ${project}
    mkdir ${project}
    curl -L https://api.github.com/repos/redhat-cip/${project}/tarball | tar xz --directory ${project} --strip=1
    popd
    rm -rf ./src/${project}
    mkdir ./src/${project}
    cp /tmp/${project}/README* ./src/${project}/
    cp -r /tmp/${project}/docs/ ./src/${project}/docs/ 2>/dev/null
    rm -rf /tmp/${project}
done

npm install
npm run build
