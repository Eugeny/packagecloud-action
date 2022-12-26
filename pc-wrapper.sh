#!/bin/bash

set -eo pipefail

for v in el/9 el/8 ol/6 ol/7
do
    echo Pushing to $1/$v
    package_cloud push --verbose --yes ${1}/${v} ${2}/*.rpm
done | tee rpmout

for v in ubuntu/bionic ubuntu/focal ubuntu/hirsute ubuntu/impish ubuntu/jammy ubuntu/kinetic debian/jessie debian/stretch debian/buster debian/bullseye debian/bookworm
do
    echo Pushing to $1/$v
    package_cloud push --yes ${1}/${v} ${2}/*.deb
done | tee debout

rpmout=$(< rpmout)
debout=$(< debout)

echo "::set-output name=rpmout::$rpmout"
echo "::set-output name=debout::$debout"
