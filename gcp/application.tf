# helm-release.tf
resource "helm_release" "laravel_mysql" {
  name       = "laravel-mysql"
  namespace  = "laravel-mysql"
  create_namespace = true
  timeout          = 600 # Aumenta el timeout a 10 minutos

  #repository = "https://github.com/Bryyyan93/practica_final.git"
  chart = "${path.module}/../charts" # Ruta local al Helm Chart
  #version    = "develop"   # Branch o versión de tu repo

  cleanup_on_fail = true # Asegura limpieza de recursos al destruir
  
  values = [
    file("${path.module}/../charts/values.yaml") # Ruta local al archivo values.yaml
  ]

  set {
    name  = "db.credentials.rootPassword"
    value = "root"
  }

  set {
    name  = "db.credentials.database"
    value = "refactorian"
  }

  set {
    name  = "db.credentials.user"
    value = "refactorian"
  }

  set {
    name  = "db.credentials.password"
    value = "refactorian"
  }

  # Opciones de sincronización similares a ArgoCD
  set {
    name  = "syncPolicy.automated.prune"
    value = "true"
  }

  set {
    name  = "syncPolicy.automated.selfHeal"
    value = "true"
  }
}
