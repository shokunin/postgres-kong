resource "docker_image" "postgres" {
  name         = "postgres:9.6"
  keep_locally = true
}

resource "docker_image" "kong" {
  name         = "kong:latest"
  keep_locally = true
}

resource "docker_container" "kong" {
  name  = "kong"
  image = "${docker_image.kong.latest}"

  ports {
    internal = 8000
    external = 8000
  }

  ports {
    internal = 8001
    external = 8001
  }


  links = [
    "${docker_container.postgres.name}",
  ]

  env = [
    "KONG_DATABASE=postgres",
    "KONG_PG_USER=${var.postgres_user}",
    "KONG_PG_PASSWORD=${var.postgres_password}",
    "KONG_PG_HOST=postgres"
  ]
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = "${docker_image.postgres.latest}"

  ports {
    internal = 5432
    external = 5433
  }

  env = [
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_USER=${var.postgres_user}",
    "PGDATA=/postgres_data",
  ]

  volumes {
    container_path = "/postgres_data"
    host_path      = "${path.module}/postgres_data"
  }
}

