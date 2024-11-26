# variables.tf

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "example-alb"
}
