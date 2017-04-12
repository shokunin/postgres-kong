variable "postgres_user" {
  description = "The Postgres user we want"
  default     = "kong"
}

variable "postgres_password" {
  description = "The Postgres password we want"
  default     = "kong"
}

variable "redis_port" {
  description = "The port we want to run redis on"
  default     = 6380
}
