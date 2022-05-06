#!/usr/bin/env bash
set -eux
temp_folder="/tmp/dci-doc"
rm -rf ${temp_folder}
mkdir ${temp_folder}
cp -r . ${temp_folder}
projects="dci-control-server dci-ui python-dciclient python-dciauth dci-downloader dci-openstack-agent dci-rhel-agent dci-openshift-agent ansible-playbook-dci-beaker dci-openshift-app-agent dci-pipeline"
for project in ${projects}
do
    echo ${project}
    rm -rf ${temp_folder}/src/${project}
    mkdir ${temp_folder}/src/${project}
    cp ../${project}/README* ${temp_folder}/src/${project}/
    cp -r ../${project}/docs/ ${temp_folder}/src/${project}/docs/ 2>/dev/null || true
done
# dci openshift app agent roles
mkdir -p ${temp_folder}/src/dci-openshift-app-agent/roles/
pushd ../dci-openshift-app-agent
for f in roles/*; do
  cp -r "${f}" ${temp_folder}/src/dci-openshift-app-agent/${f}/
done
popd

pushd ${temp_folder}
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
mkdocs build
popd
rm -rf ./docs
mkdir ./docs
cp -r ${temp_folder}/docs/ ./
rm -rf ${temp_folder}
