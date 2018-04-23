# 
# Hyperledger Fabric Install instructions
#

# Install Pre-requiste
sudo apt-get install curl
sudo apt-get update
sudo apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Docker installation
sudo apt-get update
sudo apt-get install docker-ce
# Use the below 2 commands only if the above installation has any warnining
sudo apt-get update
sudo apt-get install docker-ce --fix-missing
sudo curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# permission setting for docker user
sudo usermod -a -G docker $USER
# Install go dependent libraries
sudo apt install libtool libltdl-dev


# Install go language
curl -O https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz
tar xvf go1.8.linux-amd64.tar.gz
sudo mv go /usr/local

sudo apt install libtool libltdl-dev


# Setting /opt and /var permissions
sudo chown -R $USER:$USER /opt/
sudo chown -R $USER:$USER /var/

# GO PATH setting
export GOPATH=/opt/go/
export PATH=$PATH:/usr/local/go/bin:
mkdir -p /opt/go/src/github.com/hyperledger

source ~/.bashrc

# Installation of node JS
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash
nvm install v8.11.1

# Download Hyperledger Binaries
cd /opt/go/src/github.com/hyperledger
git clone https://github.com/hyperledger/fabric.git


# !!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!
# Download protoc-gen-go if missing and copy it under 
# /opt/go/src/github.com/hyperledger/fabric/vendor/github.com/golang/protobuf/protoc-gen-go

cd /opt/go/src/github.com/hyperledger/fabric
make configtxgen
make cryptogen
make orderer

sudo usermod -a -G docker $USER

# Restart the VM after executing the above command
make peer

# Add Fabric bin path in the last line of .bashrc file 
export FABRIC_BIN_PATH=/opt/go/src/github.com/hyperledger/fabric/build/bin
export PATH=$PATH:$FABRIC_BIN_PATH
source ~/.bashrc


sudo apt-get install openssh-server openssh-client


