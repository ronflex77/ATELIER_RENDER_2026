terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.7.0"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  # Correction pour le déploiement d'une image Docker externe
  image_runtime_source {
    image_url = "${var.image_url}:${var.image_tag}"
  }

  env_vars = {
    "ENV" = {
      value = "production"
    }
  }
}
