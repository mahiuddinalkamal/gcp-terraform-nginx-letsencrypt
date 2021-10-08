# gcp-terraform-nginx-letsencrypt
An automated way of provisioning a VM with NGINX reverse proxy and LetsEncrypt for enabling SSL and performance tuning of NGINX for 10k+ Concurrent requests  in GCP using Terraform

Steps to perform:
1. If you have already gcloud cli installed in your machine please authenticate your gcp account using "gcloud auth login", otherwise install gcloud cli and then authenticate.
2. I have created a script file for easy provisioning of the project environment needed in the Google Cloud Platform as well as deleting the project environment if needed. User "./script create" for creating the environment and "./script delete" for deleting the environment automatically.
3. Now, to provision a GCP VM using Terraform, run "./script apply". This will create VM with all needed resources along with it. Then it will run a "startscript.sh" automatically after the VM has been provisioned. This statscript will install NGINX, Certbot(for LetsEncrypt) into the VM and will create SSL certificate for a particular domain. I already have a custom domain "dev.codezonebd.com". So, I have used mine. If you wish to change it to your own domain please do so. Then, the script will tune NGINX so that it can have 10K concurrent request at any time.
4. Finally, in order to destroy the GCP Infrastructure run "./script destroy". This will trigger Terraform to destroy the whole infrastructure. Use this option with caution.
