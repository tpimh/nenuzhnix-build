DATE ?= $(shell date +%Y%m%d)
DOCKER ?= docker
TAG ?= latest
REPO ?= tpimh/nenuzhnix-build

image:
	@$(DOCKER) build -t $(REPO):$(TAG) .

deploy:
	@echo ${DOCKER_PASSWORD} | ${DOCKER} login -u ${DOCKER_USERNAME} --password-stdin
	${DOCKER} push $(REPO):$(TAG)
