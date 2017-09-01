# Installation

If you've read the [Sunbird architecture](/architecture) description, you will have read that it requires several distributed components for runtime operation. Getting started with this complexity can be a daunting task. Fortunately, we've simplified the installation process for some common scenarios.

## Choosing an installation method
Based on your usage and the level of complexity which you are comfortable with, there are a few different paths to installing and running Sunbird.

### Prerequisites
Each of the installation options requires a few pre-requisites to be satisfied. At a minimum, you should be
* Using a Linux OS flavour (developer installation is possible on MacOS)
* Comfortable with a terminal  -- Sunbird install is triggered from the command-line terminal

Note: pre-requisites are not required to try out the sandbox option.

### I want to try Sunbird
If you are looking to experiment with Sunbird and test out its feature set, we recommend you use the [Sunbird sandbox](https://staging.open-sunbird.org/) which is already running in the cloud. Note, any data created in the sandbox will be erased after 24 hours.

### I want to contribute code
If you plan to modify and contribute code to the Sunbird project, we recommend you follow the [developer installation](/install/developers) process. This will get you started quickly so you can start submitting code.

### I want 10-10K users to use Sunbird (Medium Scale)
If you plan to run Sunbird in a setting of 10-10000 users, we recommend you follow the [small/medium deployment](/install/sme) process. This option uses less resources to run Sunbird and has some limits on how much the installed application can scale.

### I want the works!
If you plan to run Sunbird in a setting with 10,000+ users, we recommend you follow the [large-scale deployment](/install/large-scale-cloud) process. This will deploy Sunbird to a cloud-hosting provider of your choice in a fully containerised manner. The containers allow you to scale the resources Sunbird consumes based on the usage.
