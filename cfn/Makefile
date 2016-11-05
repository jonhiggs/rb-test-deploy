STACK_NAME = rb-test
BUCKET_NAME = rb-test-jonhiggs

ACTION ?= create

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=ap-southeast-2

stack:
	aws cloudformation ${ACTION}-stack                                          \
		--stack-name "${STACK_NAME}"                                         \
		--template-body "file://./bucket.json"                               \
		--parameters "ParameterKey=BucketName,ParameterValue=${BUCKET_NAME}" \
		2>&1
	aws cloudformation wait stack-${ACTION}-complete \
	  --stack-name $(STACK_NAME)

origin_address:
	@aws cloudformation describe-stacks \
		--stack-name ${STACK_NAME} \
		--query 'Stacks[].Outputs[?OutputKey==`OriginAddress`].OutputValue' \
		--output text
