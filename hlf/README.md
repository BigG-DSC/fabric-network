
<!-- (SPDX-License-Identifier: CC-BY-4.0) -->  <!-- Ensure there is a newline before, and after, this line -->

# Halo Network

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/hyperledger/blockchain-explorer?sort=semver)](https://github.com/hyperledger/blockchain-explorer/releases)
<!-- badges -->

![](docs/images/Halo_Hyperledger_Logo.png)

The Halo Network is a blockchain based on IBM HyperLedger Fabric and an attempt to securely share sensitive data between the Internet of Medical Things and the real world. Built and maintained by Gioele Bigini, it is an open source infrastructure part of the Industrial Innovation PhD granted to Gioele Bigini during 2019, supervised by Prof. Emanuele Lattanzi. The following implementation has been tested on Ubuntu 18.


# Release Notes

| Hyperledger Explorer Version                      | Fabric Version Supported                                         |
| --                                                | --                                                               |
| [v1.1.7](release_notes/v1.1.7.md)                 | [v2.2](https://hyperledger-fabric.readthedocs.io/en/release-2.2) |

---

# Quick start

## Prerequisites

* Docker
* Docker Compose
  * **Note:**
    The following docker images are automatically pulled from Docker Hub when starting docker-compose.

    * [Hyperledger Fabric peer docker repository](https://hub.docker.com/r/hyperledger/fabric-peer)
    * [Hyperledger Fabric orderer docker repository](https://hub.docker.com/r/hyperledger/fabric-orderer)
    * [Hyperledger Explorer docker repository](https://hub.docker.com/r/hyperledger/explorer/)
    * [Hyperledger Explorer PostgreSQL docker repository](https://hub.docker.com/r/hyperledger/explorer-db)

## Start Hyperledger Fabric network


  ```
  $ cd hlf/network/scripts 
  $ ./networkup.sh
  $ ./createchannel
  $ ./deployChaincode

  ```


## Clean up


  ```
  $ cd hlf/network/scripts 
  $ ./networkdown.sh
  ```


# License

Hyperledger Explorer Project source code is released under the Apache 2.0 license. The README.md, CONTRIBUTING.md files, and files in the "images", "__snapshots__" folders are licensed under the Creative Commons Attribution 4.0 International License. You may obtain a copy of the license, titled CC-BY-4.0, at http://creativecommons.org/licenses/by/4.0/.