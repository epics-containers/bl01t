#!/bin/bash

# CI framework agnostic to verify all the IOC instances specified in the repo

THIS_DIR=$(dirname ${0})
set -ex

for ioc in ${THIS_DIR}/iocs/*
do
    # Skip if subfolder is not an IOC definition
    if [ ! -d "${ioc}/config" ]; then
        continue
    fi

    ec ioc validate "${ioc}"
done

