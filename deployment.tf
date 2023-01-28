resource "kubernetes_namespace" "exa" {
  metadata {
    name = "ns-tfs"
  }
}

resource "kubernetes_deployment" "exs" {
  metadata {
    name = "terraform-exs"
    labels = {
      test = "MyApp"
    }
    namespace = "ns-tfs"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "MyApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyApp"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "exa"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "svc-s" {
  metadata {
    name = "terraform-svc-s"
  
    namespace = "ns-tfs"
  }
  spec {
    selector = {
      test = kubernetes_deployment.exs.metadata.0.labels.test
      #type = "NodePort"
    }
     #session_affinity = "ClientIP"
     port {
      port        = 8080
      target_port = 80
    }

     # type = "Nodeport"
  }
  }
/*
  #kubectl proxy --port=8080
   #output       #Starting to serve on 127.0.0.1:8080
http://127.0.0.1:8080/api/v1/proxy/namespaces/ns-tfs/services/terraform-svc-s:http/


http://127.0.0.1:8080/api/v1/proxy/namespaces/ns-tfs/services/terraform-svc-s:http/


http://localhost:8080/api/v1/proxy/namespaces/ns-tfs/services/terraform-svc-s:8080/
/*
  #http://localhost:8080/api/v1/proxy/namespaces/default/services/my-internal-service:http/



   curl 127.0.0.1:8080


StatusCode        : 200
StatusDescription : OK
Content           : {
                      "paths": [

                    "/.well-known/openid-configuration",  
                        "/api",
                        "/api/v1",
                        "/apis",
                        "/apis/",

                    "/apis/admissionregistration.k8s.io", 
                        "/apis/admissionregistration.k8s. 
                    io/v1",
                       ...
RawContent        : HTTP/1.1 200 OK
                    Audit-Id:
                    558289d6-c1be-42de-8569-4d4f4df3036e
                    X-Kubernetes-Pf-Flowschema-Uid:
                    41acc795-efc7-4415-a1da-5024dcc495ff
                    X-Kubernetes-Pf-Prioritylevel-Uid:
                    33e1d72e-7310-4a59-a2da-db8c86...
Forms             : {}
Headers           : {[Audit-Id, 558289d6-c1be-42de-8569-4
                    d4f4df3036e],
                    [X-Kubernetes-Pf-Flowschema-Uid, 41ac
                    c795-efc7-4415-a1da-5024dcc495ff],
                    [X-Kubernetes-Pf-Prioritylevel-Uid, 3
                    3e1d72e-7310-4a59-a2da-db8c86cde634],
                     [Transfer-Encoding, chunked]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 5773



PS C:\Users\tosim\OneDrive\Työpöytä\Terraform>

*/
