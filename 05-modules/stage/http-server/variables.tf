variable "http_port" {
  description = "Port for HTTP server"
  default = 8081
  type = number
}

variable "additional_http_port" {
  description = "Additional HTTP port"
  default = 8080
  type = number
}