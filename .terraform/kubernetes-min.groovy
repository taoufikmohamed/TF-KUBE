//Here is an example Terraform config file containing a few Kubernetes resources. You can use minikube for the Kubernetes cluster in this example, but any Kubernetes cluster can be used. Ensure that a Kubernetes cluster of some kind is running before applying the example config below1.

resource "kubernetes_namespace" "example" {
  metadata {
    name = "example"
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "example"
  }

  spec {
    selector = {
      app = kubernetes_deployment.example.metadata.0.name
    }

    port {
      node_port   = 30007
      port        = 8080
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name = "example"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = kubernetes_deployment.example.metadata.0.name
      }
    }

    template {
      metadata {
        labels = {
          app = kubernetes_deployment.example.metadata.0.name
        }
      }

      spec {
        container {
          image = "nginx:latest"

          name = "nginx"

          ports {
            container_port = 80
          }
        }
      }
    }
  }
}