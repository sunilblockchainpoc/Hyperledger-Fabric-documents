export CC_SRC_PATH="github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02"

# Installing chain code
peer chaincode install -n mycc -v 1.0  -p $CC_SRC_PATH

# Instanstiate chain code
peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n mycc  -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "OR ('Org1MSP.peer','Org2MSP.peer')"

# Querying chaincode
peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

# Node JS
#../../../build/bin/peer chaincode install -l node -n mycc1 -v v0 -p /home/owner/nodejs-chaincode/fabric-chaincode-node/test/integration/
#../../../build/bin/peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -l node -n mycc1 -v v0 -c '{"Args":["init"]}' -P 'OR ("DEFAULT.member")'
#../../../build/bin/peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

