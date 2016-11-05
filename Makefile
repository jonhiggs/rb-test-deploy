TAG = rb-test
VOLUME = ${TAG}-html
BUCKET_NAME = rb-test-jonhiggs
ENV_FILE = ./env.list
DOCKER_CMD = docker run --volume ${VOLUME}:/tmp/html/ --env-file $(ENV_FILE) --rm=true ${TAG}:latest
AWS_CMD = docker run -it --volume ${VOLUME}:/tmp/html/ -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION jakesys/aws

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=ap-southeast-2

.PHONY: cfn cfn_update

publish: generate
	${AWS_CMD} s3 sync --acl public-read /tmp/html/ s3://${BUCKET_NAME}

generate: build volume
	@${DOCKER_CMD} generate:index

build:
	@docker build -t ${TAG} .

volume:
	@docker volume create --name ${VOLUME}

test: build
	@${DOCKER_CMD} test

update_submodule:
	@cd ./app/ && git pull && git checkout master

cfn:
	@make -C ./cfn stack ACTION=create

cfn_update:
	@make -C ./cfn stack ACTION=update

