#!/usr/bin/env bash
set -eux

rm -rf docs build
mkdir build
cp -ra src/* build

projects="dci-control-server dci-ui python-dciclient python-dciauth dci-downloader dci-openstack-agent dci-rhel-agent dci-openshift-agent dci-openshift-app-agent dci-pipeline dci-ansible"
for project in ${projects}; do
    echo "${project}"
    rsync -avm --include="*.md" --include="samples/*" --exclude=".*" --exclude="*node_modules/" --exclude="venv/*" --include="*/" --exclude="*" "../${project}/" "build/${project}/"
done

if [ ! -d venv ]; then
    python3 -m venv venv
    . venv/bin/activate
    pip install -r requirements.txt
else
    . venv/bin/activate
fi

mkdocs build
