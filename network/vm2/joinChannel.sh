export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../vm4/crypto-config/ordererOrganizations/halonetwork.com/orderers/orderer.halonetwork.com/msp/tlscacerts/tlsca.halonetwork.com-cert.pem
export PEER0_ORG2_CA=${PWD}/crypto-config/peerOrganizations/org2.halonetwork.com/peers/peer0.org2.halonetwork.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../artifacts/channel/config/

export CHANNEL_NAME=mychannel

setGlobalsForPeer0Org2() {
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org2.halonetwork.com/users/Admin@org2.halonetwork.com/msp
    export CORE_PEER_ADDRESS=localhost:9051

}

setGlobalsForPeer1Org2() {
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org2.halonetwork.com/users/Admin@org2.halonetwork.com/msp
    export CORE_PEER_ADDRESS=localhost:10051

}

fetchChannelBlock() {
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Org2
    # Replace localhost with your orderer's vm IP address
    peer channel fetch 0 ./channel-artifacts/$CHANNEL_NAME.block -o <Orderer Public IP>:7050 \
        --ordererTLSHostnameOverride orderer.halonetwork.com \
        -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
}

joinChannel() {
    setGlobalsForPeer0Org2
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

    setGlobalsForPeer1Org2
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

}

updateAnchorPeers() {
    setGlobalsForPeer0Org2
    # Replace localhost with your orderer's vm IP address
    peer channel update -o <Orderer Public IP>:7050 --ordererTLSHostnameOverride orderer.halonetwork.com \
        -c $CHANNEL_NAME -f ./../artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
}

fetchChannelBlock
joinChannel
updateAnchorPeers
