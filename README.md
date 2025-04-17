### TASK - 1

# simpletimeservice

A simple Node.js microservice that returns the current UTC timestamp and client IP address. Containerized with Docker for easy deployment.

## Prerequisites

1. **Git** ([Installation Guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git))
2. **Node.js 18+** ([Download](https://nodejs.org/))
3. **Docker** ([Installation Guide](https://docs.docker.com/get-docker/))
4. **aws cli** ([Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
5. **Terraform** (Optional, for cloud deployment) ([Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))

## Local Development

### 1. Clone Repository

Clone the repository and go inside the root folder

```
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd devops-challenge-solutions/
```

### 2. Install Dependencies

Since the microservice is based on nodejs, we have to execute this command:

```
npm install
```

npm(Node Package Manager) is a package manager in nodejs which is a registry consists of packages. This command is to make sure all the packages mentioned in package.json file will be installed.

### 3. Start Development Server

Start the server by executing:

```
npm start
```

Check if the port is not used already. If not kill the process running in that port.
Now Access the application via: http://localhost:5000 .A JSON response with your IP and a UTC timestamp is expected like below.

`{
  "timestamp": "2025-04-17T13:41:18.227Z",
  "ip": "127.0.0.1"
}`

With This the Local setup is done and tested, Let's move to containerisation part.

## Docker Deployment

### 1. Build Docker Image

Build the Docker image with the Dockerfile in th root folder.

```
docker build -t simpletimeservice .
```

### 2. Run Docker Image

With the image created, try to run the container of the image created in previos step,

```
docker run -d -p 5000:5000 simpletimeservice:latest
```

Now open your browser and go to http://localhost:5000. You’ll see a JSON response with your IP and a UTC timestamp as similar to the above step.If there is no reponse or any other issue, Check with the Docker image again. Try to Troubleshoot by checking the logs of container to check weather the nodejs server is running without any intruptions.

## Take Aways

**Smaller Docker Images**: Reduce security vulnerabilities, speed up build/pull times, and save storage/bandwidth, making deployments faster and more efficient.

**Non-root Containers**: Improve security by limiting container permissions, preventing potential malicious processes from affecting the host system or other containers.

### TASK - 2

# Terraform

This folder structure is designed to deploy AWS infrastructure with Terraform. It is modular and well-organized to handle the deployment of a Virtual Private Cloud (VPC), Elastic Kubernetes Service (EKS), Node Groups, Application Load Balancer (ALB), and IAM roles. The structure is flexible, reusable, and scalable, suitable for different environments (e.g., staging, production).

## Folder Structure

This is the Folder structure used in this project

. <br>
├── main.tf <br>
├── var.eks.tf <br>
├── var.vpc.tf <br>
├── var.eks_ng.tf <br>
├── var.elb.tf <br>
├── outputs.tf <br>
├── dev.tfvars <br>
├── backend.tf <br>
├── modules/ <br>
│ ├── vpc/ <br>
│ │ ├── main.tf <br>
│ │ ├── variables.tf <br>
│ │ ├── outputs.tf <br>
│ ├── eks/ <br>
│ │ ├── main.tf <br>
│ │ ├── variables.tf <br>
│ │ ├── outputs.tf <br>
│ ├── eks_ng/ <br>
│ │ ├── main.tf <br>
│ │ ├── variables.tf <br>
│ │ ├── outputs.tf <br>
│ ├── elb/ <br>
│ │ ├── main.tf <br>
│ │ ├── variables.tf <br>
│ │ ├── outputs.tf <br>

The Terraform folder structure is well-organized for managing infrastru\*\*cture across different environments (e.g., production) and modules

### Folder Breakdown

**root** Folder: Contains module blocks for each resource, which reference the appropriate modules from the modules directory.
**modules** Folder: Contains individual modules that define reusable Terraform configurations for specific resources.

### Files Breakdown

**var.\*\*** Files: Defines variables specifically for the services to be imported. The variables are seperated into different files for better readability.

**main.tf** Files: In `root` Folder , It defines the imports of modules to be used for provisioning the services. In `modules` subfolder, It defines all the configuration of the service dynamically.

**variables.tf** Files: Defined in the subfodler of each module, it consist of the input variables for the Infra configuration.

**outputs.tf** Files: It defines the output values that will be returned after Terraform applies the configuration. These outputs can be used to reference critical information.

## Setup

First, Check the iam user attached with the aws cli have enough IAM permission for creating these aws services.

### Init

```
terraform init
```

This command Initializes the working directory containing Terraform configuration files(Downloading the providers,setting up the backends,etc). A .terraform folder will be created which includes all the providers and modules metadata.

### Validate

```
terraform validate
```

It will validate whether the .tf files are syntactically valid and internally consistent. Before every `plan` command , try to validate the tf files.

### Plan

```
terraform plan -var-file="dev.tfvars"
```

It creates an execution plan showing what Terraform will do when you apply the changes. For multi environment purposes, use different .tfvars file.

### Apply

```
terraform apply -var-file="dev.tfvars"
```

This applies the changes required to reach the desired state of the configuration. You can check the necessary services are provisioned in the console.

## State File Management

An **S3 backend** in Terraform is used to securely store and manage the **Terraform state file** (terraform.tfstate) remotely in an Amazon S3 bucket, rather than locally on your machine. This enables **collaboration**, **locking**, and **consistency** among team members working on the same infrastructure. The backend configuration is defined in backend.tf and includes the S3 bucket name, key (file path), region, and optional settings like encryption and lock table. This setup is critical for production-grade infrastructure to track resource states reliably and support teamwork.

## Versions

Here are the versions for the services used

1. Terraform: 1.11.0+
2. Provider hashicorp/aws: 5.94.1
3. aws cli: 2.26.1
