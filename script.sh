#!/bin/bash

if [ "$1" == "" ]; then

	echo "Please provide an argument (either create | delete | apply | destroy)."

	echo "create  ==> for creating project env"

	echo "delete  ==> for deleting project env"

	echo "apply   ==> for applying terraform config"

	echo "destroy ==> for deystroying terraform config"

	exit
fi

PROJECT_NAME="coding-test-mak-final"
SERVICE_AC="coding-test-service-ac"
IAM_AC="$SERVICE_AC"@"$PROJECT_NAME".iam.gserviceaccount.com
BILLING_AC=0171E9-D99FF5-BAC6FA # change here according to your billing account number

if [ "$1" == "create" ]; then

	echo "Creating GCP Project Environment..."

	gcloud projects create "$PROJECT_NAME"

	gcloud config set project "$PROJECT_NAME"

	gcloud iam service-accounts create "$SERVICE_AC" \
	  --description="service account for terraform" \
	  --display-name="terraform_service_account"

	gcloud services enable iam.googleapis.com

	gcloud iam service-accounts list

	gcloud iam service-accounts keys create key.json --iam-account "$IAM_AC"

	gcloud services list --available | grep "Compute Engine API"

	gcloud alpha billing accounts list

	gcloud alpha billing projects link "$PROJECT_NAME" --billing-account "$BILLING_AC"

	gcloud services enable cloudresourcemanager.googleapis.com

	gcloud services enable compute.googleapis.com # for Google Compute Engine

	gcloud services enable dns.googleapis.com # for cloud DNS

	echo "Done...Created GCP Project Environment Successfully."

	exit

fi

if [ "$1" == "delete" ]; then

	echo "Deleting GCP Project Environment..."

	gcloud projects delete "$PROJECT_NAME"

	echo "Done...GCP Project Environment Setup deleted successfully."

	exit
fi
if [ "$1" == "apply" ]; then

	echo "Applying Terraform Config now..."

	terraform init

        terraform plan -var project="$PROJECT_NAME" -var email="$IAM_AC" -out terraform.tfplan

        terraform apply terraform.tfplan

        echo "Done...Infrustructure booted up successfully."

        exit
fi
if [ "$1" == "destroy" ]; then

        echo "Deleting GCP VM Insfrustructure..."

        terraform destroy -var project="$PROJECT_NAME" -var email="$IAM_AC" -auto-approve  # use with caution in order to destroy the infrastructure

	echo "Done...Infrustructure deleted successfully."

        exit
fi
