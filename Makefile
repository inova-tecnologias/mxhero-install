MXHEROVERSION ?= 2.2.4
VERSION ?= unknown
# AWS ACCESS KEY
AK ?=
# AWS SECRET KEY
SK ?= 

info:
	@echo "VERSION:          ${VERSION}"
	@echo "MXHEROVERSION:    ${MXHEROVERSION}"
	@echo "AK (ACCESSKEY):   ${AK}"
	@echo "SK (SECRETKEY):   ${SK}"

build:
	mkdir -p ./build
	wget https://s3/mxhero/releases -o packages/mxhero-amd64.deb
	tar -czf mxhero-PROFESSIONAL-${VERSION}_UBUNTU16_64.tar.gz .

push:
	aws cp ./build/mxhero-PROFESSIONAL-${VERSION}_UBUNTU16_64.tar.gz s3://mxhero/releases

.PHONY: build push
