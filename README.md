[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <img alt="delineate.io" src="https://github.com/delineateio/.github/blob/master/assets/logo.png?raw=true" height="75" />
  <h2 align="center">delineate.io</h2>
  <p align="center">portray or describe (something) precisely.</p>

  <h3 align="center">Scheduled Cloud Functions</h3>

  <p align="center">
    Demonstrate using Terraform to provision scheduled cloud functions securely on Google Cloud
    <br />
    <a href="https://github.com/delineateio/scheduled-cloud-functions"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/delineateio/scheduled-cloud-functions/issues">Report Bug</a>
    ·
    <a href="https://github.com/delineateio/scheduled-cloud-functions/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

The purpose of this repo is to demonstrate scheduling cloud functions on Google Cloud Platform.

### Built With

* [NodeJS](https://nodejs.org/en/) used as the language to implement the cloud function
* [Google Functions Framework](https://github.com/GoogleCloudPlatform/functions-framework-nodejs) enabling  better developer workflow and simplifying local development
* [Hashicorp Vagrant](https://www.vagrantup.com/) to provide a consistent and isolated developer desktop
* [Hashicorp Terraform](https://www.terraform.io/) used to provision cloud resources for the scheduled function
* [Google Cloud Platform](https://cloud.google.com/gcp) used as the hosting platform for the cloud resources

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.

> In future the GCP bootstrapping can be automated using a bootstrapping script to smooth setup.

```shell
# installs vagrant
brew install --cask vagrant

# installs httpie
brew install httpie
```

#### GCP APIs

Before running the `terraform` provisioning the following two Google Cloud APIs must be enabled:

* [Cloud Resource Manager API](https://console.cloud.google.com/marketplace/product/google/cloudresourcemanager.googleapis.com)
* [Identity and Access Management API](https://console.cloud.google.com/marketplace/product/google/iam.googleapis.com)

When using `gcloud` with a correctly authenticated and permissioned the APIs can be enabled with the following command

```shell
# enables the service
gcloud services enable "${SERVICE}" --async
```

#### Terraform Service Account

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

### Installation

```shell
# clone the repo
git clone https://github.com/delineateio/scheduled-cloud-functions.git
```

Once the repo is cloned create `./box.yml` in the root of the project.  This is required to configure `gcloud` when the `vagrant` box is provisioned.

```yml
gcloud:
  account:  # service_account_email
  key:      # service_account_key (json)
  project:  # gcp_project
  region:   # gcp_region
  zone:     # gcp_zone
```

<!-- USAGE EXAMPLES -->
## Usage

### Local Testing

The below instructions can be used to run the function locally for testing purposes, you can find out more [here](https://github.com/GoogleCloudPlatform/functions-framework-nodejs#quickstart-set-up-a-new-project).  Additionally, you can find out more by watching the [Functions Framework](https://cloud.google.com/functions/docs/functions-framework) video.

```shell
# navigate function
cd ./dev

# install and run the server
npm install
npm start

# use preferred tool from host (curl, httpie etc)
http :8080
```

### Provisioning in GCP

> It is important to note that some of the GCP resources are **eventually consistent**.  What this means in practice, is that if the scheduled job is immediately manually run from the console it sometimes fails.  However it stabilises after some time as proven by testing.

```shell
# navigate to infra
cd ./ops

# initalises the modules
terraform init

# applies the infra
terraform apply

# destroy the infrastructure (when required)
terraform destroy
```

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/delineateio/scheduled-cloud-functions/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

If you would like to contribute to any Capco Digital OSS projects please read:

* [Code of Conduct](https://github.com/delineateio/.github/blob/master/CODE_OF_CONDUCT.md)
* [Contributing Guidelines](https://github.com/delineateio/.github/blob/master/CONTRIBUTING.md)

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [Best README Template](https://github.com/othneildrew/Best-README-Template/blob/master/README.md)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/delineateio/scheduled-cloud-functions.svg?style=for-the-badge
[contributors-url]: https://github.com/delineateio/scheduled-cloud-functions/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/delineateio/scheduled-cloud-functions.svg?style=for-the-badge
[forks-url]: https://github.com/delineateio/scheduled-cloud-functions/network/members
[stars-shield]: https://img.shields.io/github/stars/delineateio/scheduled-cloud-functions.svg?style=for-the-badge
[stars-url]: https://github.com/delineateio/scheduled-cloud-functions/stargazers
[issues-shield]: https://img.shields.io/github/issues/delineateio/scheduled-cloud-functions.svg?style=for-the-badge
[issues-url]: https://github.com/delineateio/scheduled-cloud-functions/issues
[license-shield]: https://img.shields.io/github/license/delineateio/scheduled-cloud-functions.svg?style=for-the-badge
[license-url]: https://github.com/delineateio/scheduled-cloud-functions/blob/master/LICENSE
