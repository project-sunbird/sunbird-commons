# Medium scale Deployment of Sunbird

## Prerequisites
This section should expand as open source contributions to support multiple run times increase over time. Presently, the software and reference steps consider the following tech stack:

Required:
- Linux, preferably Ubuntu
- [Docker Swarm Mode](https://docs.docker.com/engine/swarm/)
- [Ansible](https://www.ansible.com/)

Optional:
- A CI server, e.x. [Jenkins](https://jenkins.io/), to build extensions and take future upgrades
- a source control mechanism, e.x. [Git](https://github.com/)

## Installation
### Production
You have a choice to use bare metal machines or go with a Cloud provider of your choice, which can provide you Linux runtime with root access. Initial scripts contain automation to setup Sunbird on [Azure](https://azure.microsoft.com/en-in/) and assume that you have a Unix runtime on the machine you are initiating the installation.
- Create a RSA 2048 bit SSH keypair
- Set up Docker Swarm Mode using [ACS-Engine](https://github.com/Azure/acs-engine)
- Bootstrap the servers using [Bootstrap script](#machine-bootstrap)
- SSH into Master node
- Clone [this repo](https://github.com/project-sunbird/sunbird-devops)
- Bootstrap [configuration](#configuration-bootstrap)
- Install [databases](#database-installations)
- Bootstrap [databases](#database-bootstrap)
- Deploy [services](#service-deploy)

## Installation Details
Getting started with installation can be a daunting task. Fortunately, we've simplified the installation process.

### Machine bootstrap
This bootstraps the VMs with initial configuration needed for automated script access.
```
ansible-playbook -i inventory/? --tags "bootstrap_any" -e "hosts=?" -e "bootstrap_secret_file=production" bootstrap.yml --ask-vault-pass
```
### Configuration bootstrap
Typically, this step configures the production environment with the basic configuration required to boot up services, e.x. DB connection strings, secrets, etc
```
ansible-playbook -i ansible/inventory/? ansible/bootstrap.yml --extra-vars hosts=production-swarm-manager swarm_master=true --tags bootstrap_swarm --vault-password-file /run/secrets/vault-pass
```
### Install Database

Sunbird uses [Mongo](https://www.mongodb.com/), [Cassandra](http://cassandra.apache.org/), [Postgres](https://www.postgresql.org/) and [Elasticsearch](https://www.elastic.co/products/elasticsearch) for various scaleable persistence and query needs.

This repo contains provisioning scripts for DBs at [ansible/provision.yml](https://github.com/project-sunbird/sunbird-devops/blob/master/ansible/provision.yml). You may use these or setup/reuse DB as appropriate in your deployment environments.

All DBs have Backup and Restore [scripts](https://github.com/project-sunbird/sunbird-devops/tree/master/ansible).

### Service deploy
Sunbird has a set of services, serving separate functional needs. Refer to [sunbird-commons](https://github.com/project-sunbird/sunbird-commons) for a better understanding of the service oriented design.
#### API Manager
```
METADATA_FILE=? ARTIFACT_LABEL=gold ENV=production ./pipelines/api-manager/deploy.sh
```
#### Proxy
```
METADATA_FILE=? ARTIFACT_LABEL=gold ENV=production ./pipelines/proxy/deploy.sh
```
#### FrontEnd
##### Player
```
METADATA_FILE=? ENV=production ARTIFACT_LABEL=gold ./pipelines/sunbird-player/deploy.sh
```
#### Middleware
##### Actor Service
```
METADATA_FILE=? ENV=production ARTIFACT_LABEL=gold ./pipelines/sunbird-actor-service/deploy.sh
```
##### Content Service
```
METADATA_FILE=? ENV=production ARTIFACT_LABEL=gold ./pipelines/sunbird-content-service/deploy.sh
```
##### Learner Service
```
METADATA_FILE=? ENV=ntp-production ARTIFACT_LABEL=gold ./pipelines/sunbird-learner-service/deploy.sh
```
```METADATA_FILE``` describes the version needed for deployment.

