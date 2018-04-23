export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
#export ORDERER_CA=/opt/go/src/github.com/hyperledger/fabric/fabric-samples/test-network/create-channel/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
rm -rf crypto-config
rm -rf channel-artifacts
mkdir crypto-config
mkdir channel-artifacts
cp -r ../crypto-config/* crypto-config/.
cp -r ../channel-artifacts/* channel-artifacts/.
cp ../core.yaml core.yaml 

echo
echo  "######### Channel Creation ################"
echo

sleep 2

#/opt/go/src/github.com/hyperledger/fabric/build/bin/peer channel create -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx --tls true --cafile $ORDERER_CA
/opt/go/src/github.com/hyperledger/fabric/build/bin/peer channel create -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/channel.tx 

echo
echo

echo
echo  "######### Peer0 of Org1 joining Channel in 7 seconds ################"
echo
sleep 7


/opt/go/src/github.com/hyperledger/fabric/build/bin/peer channel join -b mychannel.block
