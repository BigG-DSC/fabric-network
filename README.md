
<!-- (SPDX-License-Identifier: CC-BY-4.0) -->  <!-- Ensure there is a newline before, and after, this line -->

# Fabric Network Template

The HyperLedger Fabric Network is a IBM DLT for general-purpose projects. This project is open source and allow for the deployment on several virtual machines geographically distributed. The following implementation has been tested on Ubuntu 18 and has predefined certificates.

# Release Notes

| Fabric Version Supported                                         |
| --                                                               |
| [v2.2](https://hyperledger-fabric.readthedocs.io/en/release-2.2) |

# Quick start

## Prerequisites

* Docker
* Docker Compose
  * **Note:**
    The following docker images are automatically pulled from Docker Hub when starting docker-compose.

    * [Hyperledger Fabric peer docker repository](https://hub.docker.com/r/hyperledger/fabric-peer)
    * [Hyperledger Fabric orderer docker repository](https://hub.docker.com/r/hyperledger/fabric-orderer)
* Public IPs of the different machines

## Start Hyperledger Fabric network

Start the orderer first:

  ```
  $ cd network/vm4
  $ ./docker-compose -f ca/docker-compose.yaml up -d
  ```

Start the peers:

  ```
  $ cd network/vmX
  $ ./docker-compose up -d
  ```

## Create a Channel

Create the channel in the peer 1:
  ```
  $ cd network/vm1
  $ ./createChannel.sh
  ```
Join the channel in the peer 2-3:
  ```
  $ cd network/vmX
  $ ./joinChannel.sh
  ```

# License
Hyperledger Fabric Project source code is released under the Apache 2.0 license.