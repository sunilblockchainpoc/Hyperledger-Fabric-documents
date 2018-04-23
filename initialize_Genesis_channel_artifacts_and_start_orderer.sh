echo
echo "#### Clean up the existing crypto material, channel artifacts and inspect-artifacts"
echo

sleep 1
rm -rf crypto-config
rm -rf channel-artifacts
rm -rf inspect-artifacts
rm -rf org1
rm -rf org2

echo "#### Clean up the existing /var/hyperledger/production/ directory"
rm -rf  /var/hyperledger/production/*
sleep 1

echo
echo "#### Copy Crypto material ..."
cp -r /home/owner/ca-testing/crypto-config /opt/go/src/github.com/hyperledger/fabric/fabric-samples/test-network/

sleep 1
mkdir channel-artifacts
mkdir inspect-artifacts
echo
echo "#### Generate Transaction details ..."
sleep 1
echo

configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
configtxgen -inspectBlock  ./channel-artifacts/genesis.block >> ./inspect-artifacts/genesis_inspect

configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel
configtxgen -inspectChannelCreateTx  ./channel-artifacts/channel.tx >> ./inspect-artifacts/channelTX_inspect

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP
configtxgen -inspectChannelCreateTx  ./channel-artifacts/Org1MSPanchors.tx >> ./inspect-artifacts/Org1MSPanchorsTX_inspect


echo
echo "#### Create org1 details - Crypto Material & Channel artificats ..."
mkdir org1
cp -r crypto-config channel-artifacts org1/.
cp org1.core.yaml org1/core.yaml
sleep 1
echo

echo
echo "#### Org1 details - Crypto Material & Channel artificats moved to org1 ..."
scp -r org1/* owner@org1.example.com:/opt/go/src/github.com/hyperledger/fabric/fabric-samples/test-network/.
echo
echo
echo
echo
sleep 3


echo
echo "#### Create org2 details - Crypto Material & Channel artificats ..."
mkdir org2
cp -r crypto-config channel-artifacts org2/.
cp org2.core.yaml org2/core.yaml
sleep 1
echo


echo
echo "#### Org2 details - Crypto Material & Channel artificats moved to org2 ..."
scp -r org2/* owner@org2.example.com:/opt/go/src/github.com/hyperledger/fabric/fabric-samples/test-network/.
echo
echo
echo
echo
sleep 3



echo
echo
echo "!!!!!!!!!!!!!!!!!!!!!Sleep 3 seconds and Start the Orderer !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
sleep 3
orderer
