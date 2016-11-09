# mxHero installation script

```bash
./install.sh
```

## Build new release

```bash
git clone https://github.com/inova-tecnologias/mxhero-ubuntu.git
cd mxhero-ubuntu
# It will download and extract the mxhero-core.tar.gz into ./opt/mxhero
make bootstrap
# It will build a new deb file into ./build folder
make build
# Upload to AWS S3
AK=s3-access-key SK=s3-secret-key make upload 
```
