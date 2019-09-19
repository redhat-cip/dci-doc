# dci-doc

Documentation for [DCI](https://distributed-ci.io) 

## requirements

 * pandoc (yum install pandoc) if you want to build the pdf
 * node LTS
 * npm
 * [dci-dev-env](https://softwarefactory-project.io/r/dci-dev-env)

## preparation

dci-doc need to be bootstraped using `dci-dev-env/utils/bootstrap.sh`.
Clone dci-dev-env then run this script.

## run the documentation locally

    cd dci-doc
    ./build.sh
    npm install
    npm start

## build pdf

    npm run pdf
