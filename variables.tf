variable "instance_type" {
  description = "AWS Instance type"
  type        = string
  default     = "t2.micro"
}

variable "access_key" {
  description = "Access key for aws"
  type        = string
}

variable "secret_key" {
  description = "secret key foe aws"
  type        = string
}

variable "email" {
  description = "email for subscription"
  type        = string
}