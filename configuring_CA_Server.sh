#Initialize the fabric-ca-server with bootstrap password
fabric-ca-server init -c /home/owner/ca-testing/root/config.yaml -b admin:password 

# Start the Fabric CA Server with the configuration
fabric-ca-server start -c /home/owner/ca-testing/root/config.yaml -b admin:password --address orderer.example.com

# Enroll BOOTSTRAP user
fabric-ca-client enroll -u http://admin:password@orderer.example.com:7054 -c /home/owner/ca-testing/client/config.yaml

# Register multiple users

# Register Orderer
fabric-ca-client register -u "http://orderer.example.com:7054" --id.name "ordererOrg" --id.secret "password" --id.type "orderer" --id.affiliation "orderer.example.com" -c "/home/owner/ca-testing/client/config.yaml"
# Register Peer0 for Org1
fabric-ca-client register -u "http://orderer.example.com:7054" --id.name "peer0_org1" --id.secret "password" --id.type "peer" --id.affiliation "org1.example.com" -c "/home/owner/ca-testing/client/config.yaml"
# Register Peer1 for Org1
fabric-ca-client register -u "http://orderer.example.com:7054" --id.name "peer0_org2" --id.secret "password" --id.type "peer" --id.affiliation "org2.example.com" -c "/home/owner/ca-testing/client/config.yaml"

# Register Admin user Orderer
fabric-ca-client register -u "http://orderer.example.com:7054" --id.name "admin_orderer" --id.secret "password" --id.type "user" --id.affiliation "orderer.example.com" -c "/home/owner/ca-testing/client/config.yaml"
# Register Admin user org1
fabric-ca-client register -u "http://orderer.example.com:7054" --id.name "admin_org1" --id.secret "password" --id.type "user" --id.affiliation "org1.example.com" -c "/home/owner/ca-testing/client/config.yaml"
# Register Admin user org2
fabric-ca-client register -u "http://orderer.example.com:7054" --id.name "admin_org2" --id.secret "password" --id.type "user" --id.affiliation "org2.example.com" -c "/home/owner/ca-testing/client/config.yaml"

# Enrolling all the users
fabric-ca-client enroll -u http://ordererOrg:password@orderer.example.com:7054 -M /home/owner/ca-testing/orderer_msp
fabric-ca-client enroll -u http://peer0_org1:password@orderer.example.com:7054 -M /home/owner/ca-testing/peer0_org1
fabric-ca-client enroll -u http://peer0_org2:password@orderer.example.com:7054 -M /home/owner/ca-testing/peer0_org2
fabric-ca-client enroll -u http://admin_orderer:password@orderer.example.com:7054 -M /home/owner/ca-testing/admin_orderer
fabric-ca-client enroll -u http://admin_org1:password@orderer.example.com:7054 -M /home/owner/ca-testing/admin_org1
fabric-ca-client enroll -u http://admin_org2:password@orderer.example.com:7054 -M /home/owner/ca-testing/admin_org2

mkdir -p /home/owner/ca-testing/crypto-config/orderer_msp/admincerts
mkdir -p /home/owner/ca-testing/crypto-config/orderer_msp/signcerts
mkdir -p /home/owner/ca-testing/crypto-config/orderer_msp/cacerts
mkdir -p /home/owner/ca-testing/crypto-config/orderer_msp/keystore

cp /home/owner/ca-testing/orderer_msp/cacerts/*   /home/owner/ca-testing/crypto-config/orderer_msp/cacerts/
cp /home/owner/ca-testing/orderer_msp/signcerts/* /home/owner/ca-testing/crypto-config/orderer_msp/signcerts/
cp /home/owner/ca-testing/orderer_msp/keystore/* /home/owner/ca-testing/crypto-config/orderer_msp/keystore/
cp /home/owner/ca-testing/admin_orderer/signcerts/* /home/owner/ca-testing/crypto-config/orderer_msp/admincerts/

mkdir -p /home/owner/ca-testing/crypto-config/org1_msp/admincerts
mkdir -p /home/owner/ca-testing/crypto-config/org1_msp/signcerts
mkdir -p /home/owner/ca-testing/crypto-config/org1_msp/cacerts
mkdir -p /home/owner/ca-testing/crypto-config/org1_msp/keystore

cp /home/owner/ca-testing/peer0_org1/cacerts/* /home/owner/ca-testing/crypto-config/org1_msp/cacerts/
cp /home/owner/ca-testing/admin_org1/signcerts/* /home/owner/ca-testing/crypto-config/org1_msp/signcerts/
cp /home/owner/ca-testing/admin_org1/keystore/* /home/owner/ca-testing/crypto-config/org1_msp/keystore/
cp /home/owner/ca-testing/admin_org1/signcerts/* /home/owner/ca-testing/crypto-config/org1_msp/admincerts/

#cp /home/owner/ca-testing/peer0_org1/signcerts/* /home/owner/ca-testing/crypto-config/org1_msp/admincerts/
#cp /home/owner/ca-testing/peer0_org1/signcerts/* /home/owner/ca-testing/crypto-config/org1_msp/signcerts/
#cp /home/owner/ca-testing/peer0_org1/keystore/* /home/owner/ca-testing/crypto-config/org1_msp/keystore/


mkdir -p /home/owner/ca-testing/crypto-config/org2_msp/admincerts
mkdir -p /home/owner/ca-testing/crypto-config/org2_msp/signcerts
mkdir -p /home/owner/ca-testing/crypto-config/org2_msp/cacerts
mkdir -p /home/owner/ca-testing/crypto-config/org2_msp/keystore

cp /home/owner/ca-testing/peer0_org2/cacerts/* /home/owner/ca-testing/crypto-config/org2_msp/cacerts/
cp /home/owner/ca-testing/admin_org2/signcerts/* /home/owner/ca-testing/crypto-config/org2_msp/signcerts/
cp /home/owner/ca-testing/admin_org2/keystore/* /home/owner/ca-testing/crypto-config/org2_msp/keystore/
cp /home/owner/ca-testing/admin_org2/signcerts/* /home/owner/ca-testing/crypto-config/org2_msp/admincerts/

#cp /home/owner/ca-testing/peer0_org2/signcerts/* /home/owner/ca-testing/crypto-config/org2_msp/signcerts/
#cp /home/owner/ca-testing/peer0_org2/keystore/* /home/owner/ca-testing/crypto-config/org2_msp/keystore/
