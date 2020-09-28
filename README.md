# GCP Terraform Template

A template for Terraform projects on the Google Cloud Platform. It is intended for Terraform root modules (i.e. modules on which `terraform apply` is run).

Features:

- Opinionated project structure
- Clear separation between dev deployment and environment independent code (i.e. the same for dev, prod, etc.)
- Env vars are set automatically via [direnv](https://direnv.net/)
- Support for infra testing
  - Tests are executed with [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
  - All tests are executed against a dedicated testing Google Cloud project

## Installation

- Install Terraform: `brew install tfenv`, `tfenv install <version>`, `tfenv use <version>`
- Install direnv: `brew install direnv`
- Install Ruby and Bundler: `brew install ruby`, `gem install bundler`
- Download this template, e.g. by running `npx degit MajorBreakfast/gcp-terraform-template` inside an empty folder
- Install Ruby gems: `bundle install`

## Structure

- `module/*.tf`: This is the actual Terraform module. Variables parameterize anything that differs per environment (i.e. for dev, prod, etc.)
- `dev-deployment.tf`: Instantiates the module for the dev environment
- `.envrc`: Used by `direnv` to automatically set env vars when developing locally. You need to fill out this file
- `kitchen.yml`: The configuration file for the tests
- `test/`: Contains the test suites and fixtures
- `test/kitchen`: A thin wrapper around `bundle exec kitchen` which configures env vars
- `Gemfile`: Specifies the test dependencies

## Get started

- Fill out the `.envrc` file: You need a Google Cloud project, storage bucket and a service account.
- Explore the example code

## Deploy to development environment

- Open terminal
- `direnv` automatically loads the env vars
- Run `terraform apply`

## Testing

Tests are executed inside a dedicated project. This is to keep the dev environment clean.

The service account for running the tests should have broad permissions inside the test project, e.g. `roles/owner` and `roles/iam.serviceAccountTokenCreator`.

### Run all tests

- Open terminal
- `direnv` automatically loads the env vars
- Run `./test/kitchen test` to run all test suites

Any infrastructure resources created during the tests are also immediately destroyed again.

The suites are executed concurrently. Therefore, the logs of the suites are displayed in an interleaved manner. Open `.kitchen/logs/` to see the individual log of each suite.

### Work on a single test suite

- To deploy the resources of a specific suite, run `./test/kitchen converge <suite>`.
- Run `./test/kitchen verify <suite>` to run only the verification code
- To delete the resources, run `./test/kitchen destroy <suite>`. Or run `./test/kitchen destroy` to delete the resources of all suites.

## License

This template is in the public domain. Additionally, it is also licensed under either the [MIT](http://opensource.org/licenses/MIT) or [Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0) license at your option.
