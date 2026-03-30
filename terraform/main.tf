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

# 1. SERVICE DATABASE (PostgreSQL)
resource "render_postgres" "db" {
  name             = "postgres-${var.github_actor}"
  plan             = "free"
  region           = "frankfurt"
  database_name    = "tp_render_db"
  version          = "15" # Argument "version" désormais inclus
  
  # L'argument "user" a été retiré car non supporté ici
}

# 2. SERVICE BACKEND (Flask)
resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }

  env_vars = {
    "ENV"          = { value = "production" }
    # Injection de l'URL de connexion dynamique
    "DATABASE_URL" = { value = "postgresql://${render_postgres.db.user}:${render_postgres.db.password}@${render_postgres.db.host}/${render_postgres.db.database_name}" }
  }
}

# 3. SERVICE ADMINER (Gestion BDD)
resource "render_web_service" "adminer" {
  name   = "adminer-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  runtime_source = {
    image = {
      image_url = "docker.io/library/adminer"
      tag       = "latest"
    }
  }
}
