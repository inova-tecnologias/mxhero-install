# mxHero installation script

```bash
wget https://s3.amazonaws.com/mxhero/releases/mxhero-PROFESSIONAL-<VERSION>_UBUNTU16_64.tar.gz
cd mxhero-PROFESSIONAL-<VERSION>_UBUNTU16_64.tar.gz
./install.sh
```

## Build new release

```bash
git clone https://github.com/inova-tecnologias/mxhero-install.git && cd mxhero-install

VERSION=X.X.X-X make build
VERSION=X.X.X-X AK=aws-access-key-id SK=aws-secret-key make upload
```
