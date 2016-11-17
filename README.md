# mxHero installation script

```bash
wget https://s3.amazonaws.com/mxhero/releases/mxhero-PROFESSIONAL-<VERSION>_UBUNTU16_64.tar.gz
cd mxhero-PROFESSIONAL-<VERSION>_UBUNTU16_64

./install.sh

# Debug installation

./install.sh -v

# Skip the check of ports and packages
./install.sh -s FORCE_INSTALL

# Install the license - NOT IMPLEMENTED YET
./install -l /tmp/mxhero-license.xml

# Configure a default password to the web panel - NOT IMPLEMENTED YET
./install -p mysecurepasswd
```

## Build a new release

- Requires `make` for building
- Requires `awscli` for uploading

```bash
apt install -y make awscli
git clone https://github.com/inova-tecnologias/mxhero-install.git && cd mxhero-install

VERSION=X.X.X-X make build
VERSION=X.X.X-X AK=aws-access-key-id SK=aws-secret-key make upload
```

> *WARNING:* passing the aws credentials through bash will keep then memorized on the user history,
> make sure to clean it up or put the credentials into a file and export it properly.
