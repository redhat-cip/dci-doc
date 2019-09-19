#!/usr/bin/env bash

temp_folder="/tmp/dci-doc"
rm -rf ${temp_folder}
mkdir ${temp_folder}
cp -r . ${temp_folder}
ls -alh ${temp_folder}
projects="dci-control-server dci-ui python-dciclient python-dciauth dci-downloader dci-openstack-agent dci-rhel-agent ansible-playbook-dci-beaker"
for project in ${projects}
do
    rm -rf ${temp_folder}/src/${project}
    mkdir ${temp_folder}/src/${project}
    cp ../${project}/README* ${temp_folder}/src/${project}/
    cp -r ../${project}/docs/ ${temp_folder}/src/${project}/docs/ 2>/dev/null
done
pushd ${temp_folder}
npm install
npm run build
popd
rm -rf ./docs
mkdir ./docs
cp -r ${temp_folder}/_book/* ./docs/
rm -rf ${temp_folder}
