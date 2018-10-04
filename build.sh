#!/usr/bin/env bash

projects="dci-ui python-dciclient python-dciauth dci-control-server dci-ansible dci-openstack-agent dci-dev-env dci-rhel-agent"
for project in ${projects}
do
    mkdir -p ./src/${project}
    curl -L https://api.github.com/repos/redhat-cip/${project}/tarball| tar xfz - --wildcards --no-anchored 'README*.md' --strip-components=1 --one-top-level=./src/${project}
done

if [ -n "${DCI_ORIGINAL_PROJECT_NAME}" ]; then
    test -d ./src/${DCI_ORIGINAL_PROJECT_NAME} && cp -rv ${DCI_ORIGINAL_PROJECT_SRC_DIR}/README*.md ./src/${DCI_ORIGINAL_PROJECT_NAME}
fi

npm install
npm run build
