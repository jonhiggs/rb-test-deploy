TAG = rb-test
VOLUME = ${TAG}-html
BUCKET_NAME = rb-test-jonhiggs
ENV_FILE = ./env.list
DOCKER_CMD = docker run --volume ${VOLUME}:/tmp/html/ --env-file $(ENV_FILE) --rm=true ${TAG}:latest

.PHONY: cfn cfn_update

build:
	docker build -t ${TAG} .

generate: volume
	@${DOCKER_CMD} generate:index

publish: generate
	echo "aws s3 cp"

test: build
	@${DOCKER_CMD} test

volume:
	docker volume create --name ${VOLUME}

interactive:
	docker run -it \
		--volume ${VOLUME}:/tmp/html/ \
		--env-file $(ENV_FILE) \
		--entrypoint "/bin/sh" \
		--rm=true ${TAG}:latest

update_submodule:
	cd ./app/ && git pull && git checkout master

cfn:
	make -C ./cfn stack ACTION=create

cfn_update:
	make -C ./cfn stack ACTION=update

