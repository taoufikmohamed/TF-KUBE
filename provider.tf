provider "kubernetes" {
  config_path = "~/.kube/config"
}
#
/*terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
  backend "local"{
    path = "/tmp1/terraform.tfstate"
  }
}
  provider "kubernetes"{
    host = "https://x.x.x.x:8443"  # minikube ip (single node)  kubectl config view  
  }
/*
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}
provider "kubernetes" {
  host = "https://x.x.x.x:8443"
  client_certificate     = "${file("~/.kube/client-cert.pem")}"
  client_key             = "${file("~/.kube/client-key.pem")}"
  cluster_ca_certificate = "${file("~/.kube/cluster-ca-cert.pem")}"
}*/
