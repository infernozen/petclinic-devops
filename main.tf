terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.0.0"
    }
  }
}

terraform {
 backend "gcs" {
   bucket  = "infernozen-bucket-tfstate"
   prefix  = "terraform/state"
 }
}
