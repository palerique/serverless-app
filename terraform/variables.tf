variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "DYNAMODB_TABLE" {
  type    = string
  default = "Heroes"
}
