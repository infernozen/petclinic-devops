# If you have your default VPC available then use it. 

# packer puglin for GCP
# https://developer.hashicorp.com/packer/integrations/hashicorp/googlecompute
packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

# which machine-image to use as the base and where to save it
source "googlecompute" "google-linux" {
  project_id          = "infernozen"
  machine_type        = "e2-micro"
  account_file        = "key.json"
  image_name          = "gcp-ami-{{timestamp}}"
  source_image        = "ubuntu-2004-focal-v20230907"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "rosangcp"
  zone                = "asia-south1-c"
}

# what to install, configure and file to copy/execute
build {
  name = "hq-packer"
  sources = ["sources.googlecompute.google-linux"]

  provisioner "file" {
  source = "provisioner.sh"
  destination = "/tmp/provisioner.sh"
}

  provisioner "shell" {
    inline = ["chmod a+x /tmp/provisioner.sh"]
  }
  
  provisioner "shell" {
    inline = [ "ls -la /tmp"]
  }
  
    provisioner "shell" {
    inline = [ "pwd"]
  }
  
  provisioner "shell" {
    inline = [ "cat /tmp/provisioner.sh"]
  }

  provisioner "shell" {
    inline = ["/bin/bash -x /tmp/provisioner.sh"]
  }
}
