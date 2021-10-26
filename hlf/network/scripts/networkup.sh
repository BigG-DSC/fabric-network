#!/bin/bash

pushd ~/hlf/network/docker
docker-compose -f ./docker-compose-test-net.yaml up -d
popd
