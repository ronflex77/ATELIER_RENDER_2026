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

# Rappel : Les variables sont déclarées dans variables.tf
# On ne les re-déclare pas ici pour éviter l'erreur "Duplicate variable"

resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  # Correction : Séparation de image_url et tag
  # image_url doit être : ghcr.io/ronflex77/flask-render-iac
  # tag doit être : ${{ github.sha }}
  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }

  env_vars = {
    "ENV" = {
      value = "production"
    }
  }
}
