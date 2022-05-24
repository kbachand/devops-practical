# Devops-Practical
 
## General-Information

Overview: Kubernetes cluster is greated with Terraform and utilizing GKE and is built using scaling in mind as well as flexibility to deploy easily with Helm(v3). Three node cluster. The helm chart is utilizing a sub-chart to install mongodb. 

#### To utilize this repo you will need the following. 

Terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli

Helm v3: https://helm.sh/docs/intro/install/

kubectl: https://kubernetes.io/docs/tasks/tools/


To clone this repo:
```
git clone https://github.com/kbachand/devops-practical.git
```

## Table of contents

- [GCPSetup](#gcpsetup)
- [Terraform](#terraform)
- [Helm](#helm)
- [Viewing](#viewing)
- [Cleanup](#cleanup)
- [Docker](#docker)

# GCPSetup
If you don't have a google cloud account you will need to create one. The steps below are intended for post account creation and assumes you having a GCP account with Kubernetes API enabled already as well as assumption you have Gcloud CLI installed. If you don't have Gcloud CLI installed refer to https://cloud.google.com/sdk/docs/install

Will prompt you to login to be able to utilize gcloud cli.
```
gcloud auth login
```
Google Auth Library which is required.
```
gcloud auth application-default login 
```

## Terraform 

Once your authenticated its time to use Terraform to create the cluster. These commands will assume you are in the correct directory. `/devops-practical/terraform`

Initilize - may take a moment.
```
terraform init
```
Plan - will allow you to see the changes prior to applying. 
```
terraform plan
```
Apply - This will build out the infrastructure. Please allow time for this to complete.
```
terraform apply
```

### Helm 

These commands assume your Kubernetes cluster is up and running and you have created an entry point into your cluster and your in the correct directory `/devops-practical/`.

Create entry point into your cluster (replace YOUR-PROJECT-ID with the project id from your gcp account)
```
gcloud container clusters get-credentials devops-practical-prod --region us-east1 --project YOUR-PROJECT-ID
```
Install helm chart
```
helm install devops-practical devops-practical-chart
```

This will install the helm chart as-is. There are numerous configuration options within the values.yaml file in. 

Once done seeing the magic - To remove the helm chart deployment run the following.
```
helm uninstall devops-practical
```

### Viewing
This is how to view the application once deployed via Helm v3. A loadbalancer named `frontend` will be created and exposed. 

To get the EXTERNAL-IP to put in your browser.
```
kubectl get svc frontend
```
Copy the EXTERNAL-IP and paste in your browser. 

example: Your IP will be different but should look similar to the example below.
```
34.148.888.000
```
### Cleanup
Once your done playing with the application (yes its pretty neat!) the following steps will provide cleanup.

Uninstall the Helm Chart
```
helm uninstall devops-practical 
```
Destroy the created infrastructure via Terraform. You must uninstall the helm chart prior to running the below command. 
```
terraform destroy
```


## Docker 
If you prefer to view this application locally you can utilize docker. You MUST have Docker installed - https://docs.docker.com/engine/install/. You must also clone the codebase for the application and place it in the same directory as the Dockefile and docker-compose.yaml file https://github.com/swimlane/devops-practical. 

The Dockerfile and docker-compose.yaml file must be in the same directory as the application. 
```
git clone https://github.com/swimlane/devops-practical
```

To run the application - assuming the Dockerfile and docker-compose.yaml file is in the same directory as the application. 
```
docker compose up
```

Viewing the application can be done by visiting `localhost:3000` in your browser. 

Once your done you must run the following. 

```
press ctrl C
```
Compose down. 
```
docker compose down -v
```
