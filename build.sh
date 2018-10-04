#!/usr/bin/env bash

projects="dci-ui python-dciclient python-dciauth dci-control-server dci-ansible dci-openstack-agent dci-dev-env dci-rhel-agent"
for project in ${projects}
do
    pushd /tmp
    rm -rf ${project}
    mkdir ${project}
    curl -L https://api.github.com/repos/redhat-cip/${project}/tarball | tar xz --directory ${project} --strip=1
    popd
    rm -rf ./src/${project}
    mkdir ./src/${project}
    cp -v /tmp/${project}/README* ./src/${project}/
    cp -rv /tmp/${project}/docs/* ./src/${project}/ 2>/dev/null
    rm -rf /tmp/${project}
done

if [ -n "${DCI_ORIGINAL_PROJECT_NAME}" ] && [ -n "${DCI_ORIGINAL_PROJECT_SRC_DIR}" ]; then
    test -d ./src/${DCI_ORIGINAL_PROJECT_NAME} && cp -v ${DCI_ORIGINAL_PROJECT_SRC_DIR}/README*.md ./src/${DCI_ORIGINAL_PROJECT_NAME}
    test -d ./src/${DCI_ORIGINAL_PROJECT_NAME}/docs && cp -rv ${DCI_ORIGINAL_PROJECT_SRC_DIR}/docs/* ./src/${DCI_ORIGINAL_PROJECT_NAME}
fi

npm install
npm run build
