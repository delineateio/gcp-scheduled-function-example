<p align="center">
  <img alt="delineate.io" src="https://github.com/delineateio/.github/blob/master/assets/logo.png?raw=true" height="75" />
  <h2 align="center">delineate.io</h2>
  <p align="center">portray or describe (something) precisely.</p>
</p>

# Scheduled Cloud Functions

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-ff69b4.svg)](https://github.com/delineateio/box/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22+)

## Purpose

The purpose of this repo is to demonstrate scheduling cloud functions on Google Cloud Platform.

Specifically this demonstrates the following combination of technologies:

* [NodeJS](https://nodejs.org/en/) used as the language to implement the cloud function
* [Google Functions Framework](https://github.com/GoogleCloudPlatform/functions-framework-nodejs) enabling  better developer workflow and simplifying local development
* [Hashicorp Vagrant](https://www.vagrantup.com/) to provide a consistent and isolated developer desktop
* [Hashicorp Terraform](https://www.terraform.io/) used to provision cloud resources for the scheduled function
* [Google Cloud Platform](https://cloud.google.com/gcp) used as the hosting platform for the cloud resources

## Contributing

Contributions to this project are welcome!

* [Contribution Guidelines](https://github.com/delineateio/.github/blob/master/CONTRIBUTING.md)
* [Code of Conduct](https://github.com/delineateio/.github/blob/master/CODE_OF_CONDUCT.md)

Please note that [git commit signing](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work) is required to contribute to this project.

## High Level Approach

* Basic Cloud Function implemented using nodejs
* Use Cloud Functions Framework for local testing
* Use Terraform to provision the function and scheduler

## Prerequisites

> In future the GCP bootstrapping can be automated using a bootstrapping script to smooth setup.

### GCP APIs

Before running the `terraform` provisioning the following two Google Cloud APIs must be enabled:

* [Cloud Resource Manager API](https://console.cloud.google.com/marketplace/product/google/cloudresourcemanager.googleapis.com)
* [Identity and Access Management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)

When using `gcloud` with a correctly authenticated and permissioned the APIs can be enabled with the following command

```shell
# enables the service
gcloud services enable "${SERVICE}" --async
```

### Terraform Service Account

Once the right APIs are enabled a service account for `terraform` needs to be created with the following roles:

* App Engine Creator
* Cloud Functions Admin
* Cloud Scheduler Admin
* Service Account Admin
* Create Service Accounts
* Service Account User
* Project IAM Admin
* Service Usage Admin
* Storage Admin
* Storage Object Admin

### GCP Authentication

Once the GCP service account is created then a `./box.yml` file can be created in the root of the project.  This is required to configure `gcloud` when the `vagrant` box is provisioned.

```yml
gcloud:
  account:  # service_account_email
  key:      # service_account_key (json)
  project:  # gcp_project
  region:   # gcp_region
  zone:     # gcp_zone
```

## Vagrant Box

Once the prerequisites are setup the `vagrant` box can be provisioned

```shell
# creates the VM box
vagrant up --provider virtualbox
vagrant ssh

# configure the box
box

# moves into the project and set the env vars
cd project && source ./ops/.env
```

## Local Testing

The below instructions can be used to run the function locally for testing purposes, you can find out more [here](https://github.com/GoogleCloudPlatform/functions-framework-nodejs#quickstart-set-up-a-new-project).  Additionally, you can find out more by watching the [Functions Framework](https://cloud.google.com/functions/docs/functions-framework) video.

```shell
# start the function in the
cd ./dev
npm init
npm install @google-cloud/functions-framework
npm start

# from the host use your preferred tool (curl, httpie etc)
http :8080
```

## Provisioning in GCP

> It is important to note that some of the GCP resources are **eventually consistent**.  What this means in practice, is that if the scheduled job is immediately manually run from the console it sometimes fails.  However it stabilises after some time as proven by testing.

```shell
cd ./ops

# initalises the modules
terraform init

# applies the infra
terraform apply

# destroy the infrastructure (when required)
terraform destroy
```
