# dci-doc

Documentation for [DCI](https://distributed-ci.io)

## requirements

- python3
- [dci-dev-env](https://softwarefactory-project.io/r/dci-dev-env)

## preparation

dci-doc need to be bootstraped in a dci-dev-env environment.
Clone dci-dev-env then run `dci-dev-env/utils/bootstrap.sh`.

## run the documentation locally

    cd dci-doc
    ./build.sh
    cd docs
    python -m http.server -b 0.0.0.0
