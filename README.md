# Camera Images - Deployment Tooling

The deployment tooling for the [Camera Images](/jonhiggs/rb-test) project.

## Setup

Make sure that the following environment variables are properly set:

1. `export AWS_ACCESS_KEY_ID="your_id"`
1. `export AWS_SECRET_ACCESS_KEY="your_secret_key"`
1. Pull in the app with `make update_submodule`.
1. Create the CloudFormation stack with `make cfn`.

## Usage

To generate a new set of HTML files and publish them into your S3 bucket, run `make publish`.

## Testing

The test suite can be ran with `make test`.

## Updating

To use a new version of the application, you will need to [update the submodule reference](https://chrisjean.com/git-submodules-adding-using-removing-and-updating/).

To update the CloudFormation stack, make changes to `./cfn/bucket.json`, then deploy with `make cnf_update`.
