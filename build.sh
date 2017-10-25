#!/usr/bin/env bash

projects="dci-ui dci-ansible"
for project in ${projects}
do
    pushd /tmp
    rm -rf ${project}
    mkdir ${project}
    curl -L https://api.github.com/repos/redhat-cip/${project}/tarball | tar xz --directory ${project} --strip=1
    popd
    rm -rf ./src/${project}
    mkdir ./src/${project}
    cp /tmp/${project}/README.md ./src/${project}/README.md
    cp -r /tmp/${project}/docs/ ./src/${project}/docs/ 2>/dev/null
    rm -rf /tmp/${project}
done

npm install
npm run build
