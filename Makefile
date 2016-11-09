MXHEROVERSION ?= 2.2.4
VERSION ?= unknown
# AWS ACCESS KEY
AK ?=
# AWS SECRET KEY
SK ?=

export AWS_ACCESS_KEY_ID=${AK}
export AWS_SECRET_ACCESS_KEY=${SK}

info:
	@echo "MXHEROVERSION (.deb version):     ${MXHEROVERSION}"
	@echo "VERSION (this package version):   ${VERSION}"
	@echo "AK (aws accesskey):               ${AK}"
	@echo "SK (aws secretkey):               ${SK}"

build:
	mkdir -p ./build
	curl -L https://s3.amazonaws.com/mxhero/releases/mxhero_${MXHEROVERSION}_amd64.deb > packages/mxhero-amd64.deb
	dpkg --info packages/mxhero-amd64.deb >/dev/null
	tar --transform "s/^\./mxhero-PROFESSIONAL-${VERSION}_UBUNTU16_64/" -czf build/mxhero-PROFESSIONAL-${VERSION}_UBUNTU16_64.tar.gz --exclude=*.tar.gz --exclude=.git* --exclude=Makefile .

upload:
	aws s3 cp ./build/mxhero-PROFESSIONAL-${VERSION}_UBUNTU16_64.tar.gz s3://mxhero/releases

.PHONY: build upload
