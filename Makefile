TAG = rb-test
ENV_FILE = ./env.list

build:
	docker build -t ${TAG} .

generate:

publish:

test:
	@docker run \
		--env-file $(ENV_FILE) \
		--rm=true \
		${TAG}:latest


interactive:
	docker run -it \
		--env-file $(ENV_FILE) \
		--rm=true \
		--entrypoint "/bin/sh" \
		${TAG}:latest
