resource "helm_release" "laravel_mysql" {
  name       = "laravel-mysql"
  repository = var.helm_chart_repo
  chart      = "charts"

  values = [
    file("${path.module}/../charts/values.yaml")
  ]

  set {
    name  = "ingress.host"              
    value = var.ingress_host
  }

  set {
    name  = "db.pvc.storage"
    value = "10Gi"
  }
}
