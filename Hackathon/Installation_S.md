## Table of contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
    - [Developer](#developer)
    - [Production](#production)
- [Installation Details](#installation-details)
- [Deployment architecture](#deployment-architecture)
- [License](#license)

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
### Developer
Head over to specific Frontend or Backend service repos in [Project Sunbird](https://github.com/project-sunbird/) to understand how to run the parts of the stack locally, perhaps on your laptop. 
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
Following are some sample commands to automate various acts. Replace ? as appropriate. Understanding of Ansible is expected.
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

## Deployment Architecture

### Infrastructure
Sunbird can run on Virtual Machines (VMs) on various Cloud providers or bare metal. Cloud Infrastructure automation is work in progress.

### Stable Builds Registry
Sunbird builds are available at a [Image Registry](https://hub.docker.com/u/sunbird/dashboard/). These builds are in the form of a [Dockerfile](https://docs.docker.com/engine/reference/builder/). Stable releases are tagged as ```gold```. Deployment scripts pull the ```gold``` images for production deployment. The ```gold``` images are also versioned to allow for release management and upgrade paths.

### Software Runtime
Most runtimes in Sunbird are containerized as [Docker containers](https://www.docker.com/what-container) for portability, process isolation and standardization.  
For container orchestration, this repo contains scripts to run Sunbird on [Docker Swarm](https://docs.docker.com/engine/swarm/). Cloud providers provide container services. In this repo, we are using [ACS-Engine](https://github.com/Azure/acs-engine).

### Logging, Monitoring and Operational dashboards
Sunbird comes with log aggregation and metrics reporting out of the box. For log aggregation, Sunbird is using a combination of [cAdvisor](https://github.com/google/cadvisor), [ELK stack](https://www.elastic.co/webinars/introduction-elk-stack), [Prometheus](https://prometheus.io/) and their plugin ecosystem.
Ops dashboards are built using [Grafana](https://grafana.com/) with some [reference](https://github.com/project-sunbird/sunbird-devops/tree/master/cloud/monitoring/grafana) dashboards.

### Custom builds
Sunbird is extendible. Sunbird can be taken as a base image with custom implementation of public interfaces and rebuilt for deployment. Scripts are available for ramping up of complex deployments with support to run local build promotions and deployments.

## License
The code in this repository is licensed under AGPL-3.0 unless otherwise noted. Please see the [LICENSE](https://github.com/project-sunbird/sunbird-devops/blob/master/LICENSE) file for details.

