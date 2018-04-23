#start composer playground
# This command starts the composer playground
composer-playground

# Delete the existing card by issuing this command
rm -rf ~/.composer

#Card creation command
composer card create -p connection.json -u PeerAdmin -c Admin@org1.example.com-cert.pem -k 49a742ca08ed15ecf4067d103b4691cfe0a1b401374f938c65a8daaef6ecc0b5_sk -r PeerAdmin -r ChannelAdmin
composer card create -p connection.json -u ShrimpAdmin -c Admin@org1.example.com-cert.pem -k 49a742ca08ed15ecf4067d103b4691cfe0a1b401374f938c65a8daaef6ecc0b5_sk -n shrimp-network

#Card import command
composer card import -f PeerAdmin@test-network.card

# Create a dummy Business network in the specified path
yo hyperledger-composer:businessnetwork


# Create archive of network
composer archive create --sourceType dir --sourceName /home/owner/composer-testing/Business_Network/test-network/ -a test-network.bna

# Composer BNA installation
composer network install -a /home/owner/composer-testing/Business_Network/test-network/test-network.bna -c PeerAdmin@test-network

# 
#
#
composer network start -c PeerAdmin@test-network --networkName shrimp-network --networkVersion "0.0.1" -A ShrimpAdmin -S password 

composer network start -c PeerAdmin@test-network --networkName shrimp-network --networkVersion "0.0.1" -A admin -S adminpw


composer participant add -c myadmin@my-networks -d '{"$class":"org1.example.com.Trader","tradeId":"t12","firstName":"Charles","lastName":"Thomas"}'
composer participant add -c myadmin@my-networks -d '{"$class":"org1.example.com.Trader","tradeId":"t13","firstName":"Sunil","lastName":"Gunasekaran"}'

composer transaction submit -c myadmin@my-networks -d '{"$class": "org1.example.com.Commodity","tradingSymbol": "ABC","description": "Test commodity","mainExchange": "Euronext","quantity": 72.297,"owner":"resource:org1.example.com#t12"}'


composer transaction submit -c myadmin@my-networks -d '{"$class": "org.hyperledger.composer.system.AddAsset","registryType": "Asset","registryId": "org1.example.com.Commodity", "targetRegistry" : "resource:org.hyperledger.composer.system.AssetRegistry#org1.example.com.Commodity", "resources": [{"$class": "org1.example.com.Commodity","tradingSymbol": "Ag","owner": "resource:org1.example.com.Trader#t12","description": "a lot of gold", "mainExchange": "exchange", "quantity" : 250}]}'
composer transaction submit -c myadmin@my-networks -d '{"$class": "org1.example.com.Trade", "commodity": "resource:org1.example.com.Commodity#Ag", "newOwner": "resource:org1.example.com.Trader#t13"}'


composer transaction submit -c ShrimpAdmin@shrimp-network -d '{"$class": "org1.example.com.Commodity","tradingSymbol": "ABC","description": "Test commodity","mainExchange": "Euronext","quantity": 72.297,"owner":"resource:org1.example.com#t12"}'
                                                             { "$class": "org1.example.com.Commodity","tradingSymbol": "1189","description": "", "mainExchange": "",  "quantity": 0,  "owner": "resource:org1.example.com.Trader#t12"}
{
"$class": "org.acme.mynetwork.Trader",
"tradeId": "TRADER1",
"firstName": "Jenny",
"lastName": "Jones"
}