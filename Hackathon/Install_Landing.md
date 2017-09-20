
# Installation

If you've read the [Sunbird architecture](/architecture) description, you will be aware that it requires several distributed components for runtime operation.This is web-based system,which means there there is no executable file (aka no .exe files), and it must  run on a web server and accessed through a web browser. Getting started with this complexity can be cumbersome. Fortunately, we've simplified the installation process for some common scenarios.

## Choosing an installation method
Based on your usage and the level of complexity which you are comfortable with, there are a few different paths to installing and running Sunbird.

### Prerequisites
Each of the installation options requires a few pre-requisites to be satisfied. At a minimum, you should be
* Using a Linux OS flavour (developer installation is possible on MacOS)
* Comfortable with a terminal  -- Sunbird install is triggered from the command-line terminal

Note: pre-requisites are not required to try out the sandbox option.

### I want to try Sunbird
If you are looking to experiment with Sunbird and test out its feature set, we recommend you use the [Sunbird sandbox](https://staging.open-sunbird.org/) which is already running in the cloud. Note, any data created in the sandbox will be erased after 24 hours.

### I want to extend Sunbird
If you plan to modify and contribute code to the Sunbird project, we recommend you follow the [developer installation](https://github.com/project-sunbird/sunbird-commons/blob/master/Hackathon/developer_installation.md) process. This will get you started quickly so you can start submitting code.

### I want a medium scale deployment of Sunird 
If you plan to run Sunbird in a setting of 10k users, we recommend you follow the [small/medium deployment](https://github.com/project-sunbird/sunbird-commons/blob/master/Hackathon/Installation_S.md) process. This option uses less resources to run Sunbird and has some limits on how much the installed application can scale.

### I want an Enterprise deployment of Sunbird 
If you plan to run Sunbird in a setting with 10k+ users, we recommend you follow the [large-scale deployment](/install/large-scale-cloud) process. This will deploy Sunbird to a cloud-hosting provider of your choice in a fully containerised manner. The containers allow you to scale the resources Sunbird consumes based on the usage.
