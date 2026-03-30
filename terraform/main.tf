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

# 1. DATABASE
resource "render_postgres" "db" {
  name             = "postgres-${var.github_actor}"
  plan             = "free"
  region           = "frankfurt"
  database_name    = "tp_render_db"
  version          = "15"
}

# 2. BACKEND FLASK
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
    "DATABASE_URL" = { value = render_postgres.db.connection_info.internal_connection_string }
  }
}

# 3. ADMINER
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
