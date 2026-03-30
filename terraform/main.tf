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

variable "render_api_key" {}
variable "render_owner_id" {}
variable "image_url" {}
variable "image_tag" {}
variable "github_actor" {
  description = "GitHub username"
  type        = string
}

resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  runtime_source = {
    docker = {
      image_url = "${var.image_url}:${var.image_tag}"
    }
  }

  env_vars = {
    "ENV" = {
      value = "production"
    }
  }
}
