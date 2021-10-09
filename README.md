# gcp-terraform-nginx-letsencrypt
An automated way of provisioning a VM with NGINX reverse proxy and LetsEncrypt for enabling SSL and performance tuning of NGINX for 10k+ Concurrent requests  in GCP using Terraform

Steps to perform:

1. If you have already **gcloud cli** installed in your machine please authenticate your gcp account using "**gcloud auth login**", otherwise please install gcloud cli first and then authenticate.

2. I have created a script file (**script.sh**) for easy provisioning of the project environment needed in the Google Cloud Platform as well as deleting the project environment if needed. Run "**./script create**" for creating the environment and "**./script delete**" for deleting the environment automatically.

3. Now, to provision a GCP VM using Terraform, run "**./script apply**". This will create VM with all the needed resources along with it. Then it will run a "**startupscript.sh**" automatically after the VM has been provisioned. This statscript will install **NGINX, Certbot(for LetsEncrypt)** into the VM and will create SSL certificate for a particular domain. I already have a custom domain "**dev.codezonebd.com**". So, I have used mine. If you wish to change it to your own domain please do so. Then, the script will tune NGINX so that it can have 10K concurrent request at any time.

4. Finally, in order to destroy the GCP Infrastructure run "./script destroy". This will trigger Terraform to destroy the whole infrastructure. Use this option with caution.

**The VM can be reached at: https://dev.codezonebd.com**

**For accessing the VM via ssh: ssh test-user@dev.codezonebd.com** (N.B. You will need to use your key-pair while provisioning the VM for access it)

**N.B.** Since, I do not have to access to change my DNS Name Server to the Google Cloud DNS Name Server, I have explicitly added an "A" record to in my custom domain's zone setting to point to the VM's static external IP. This is needed. Nevertheless, I have also added an "A" record zone entry to the Google Cloud DNS for the custom domain name pointing towards the VM's static external IP. So, if your domain provider gives you the access to change the Name Server to Google's Name Server, please do so. Because, this way you would not need to create an "A" record explicitly in your custom domain providers zone entry.
