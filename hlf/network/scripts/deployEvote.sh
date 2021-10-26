#!/bin/bash

# return to the network folder
pushd ~/hlf/network

# set cfg path
export PATH="$PWD/../bin:$PATH"
export FABRIC_CFG_PATH=$PWD/../config

# package the chaincode
peer lifecycle chaincode package evote.tar.gz --path ../chaincode/evote/javascript --lang node --label evote_1

# Set environment to Org1
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="BiginiMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/bigini.halonetwork.com/peers/peer0.bigini.halonetwork.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/bigini.halonetwork.com/users/Admin@bigini.halonetwork.com/msp
export CORE_PEER_ADDRESS=localhost:7051

# Install the chaincode
peer lifecycle chaincode install evote.tar.gz

# Set environment to Org2
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="LattanziMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/lattanzi.halonetwork.com/peers/peer0.lattanzi.halonetwork.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/lattanzi.halonetwork.com/users/Admin@lattanzi.halonetwork.com/msp
export CORE_PEER_ADDRESS=localhost:9051

# Install the chaincode
peer lifecycle chaincode install evote.tar.gz

#######################
## approve chaincode ##
#######################

# Get the package ID of our chaincode
peer lifecycle chaincode queryinstalled &>log.txt

# export the ID as a variable
CC_PACKAGE_ID=$(sed -n "/$(CC_NAME)_$(CC_VERSION)/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)

# approve for Org2
peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.halonetwork.com --channelID channel1 --name evote --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem

# Check the approvals
peer lifecycle chaincode checkcommitreadiness --channelID channel1 --name evote --version 1.0 --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem --output json

# Set environment to Org1
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="BiginiMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/bigini.halonetwork.com/peers/peer0.bigini.halonetwork.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/bigini.halonetwork.com/users/Admin@bigini.halonetwork.com/msp
export CORE_PEER_ADDRESS=localhost:7051

# approve for Org1
peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.halonetwork.com --channelID channel1 --name evote --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem

# Check the approvals
peer lifecycle chaincode checkcommitreadiness --channelID channel1 --name evote --version 1.0 --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem --output json

# Commit the approved chaincode for both of the organizations
peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.halonetwork.com --channelID channel1 --name evote --version 1.0 --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/bigini.halonetwork.com/peers/peer0.bigini.halonetwork.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/lattanzi.halonetwork.com/peers/peer0.lattanzi.halonetwork.com/tls/ca.crt

# checkout all the chaincode defenitions on the channel
peer lifecycle chaincode querycommitted --channelID channel1 --name evote --cafile ${PWD}/organizations/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem

# initialize the chaincode 
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.halonetwork.com --tls --cafile ${PWD}/organizations/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem -C channel1 -n evote --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/bigini.halonetwork.com/peers/peer0.bigini.halonetwork.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/lattanzi.halonetwork.com/peers/peer0.lattanzi.halonetwork.com/tls/ca.crt -c '{"function":"InitLedger","Args":[]}'

