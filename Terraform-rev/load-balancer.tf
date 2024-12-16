resource "kubernetes_ingress_v1" "laravel_ingress" {
  metadata {
    name      = "laravel-ingress"
    namespace = "laravel-mysql"

    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      host = "practica.local"

      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "laravel-mysql-nginx"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
