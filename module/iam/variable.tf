variable "aws_region" {
  type = string
}

variable "aws_iam_group" {
  type = string
}

variable "policy_arn" {
  type = string
}

variable "tags" {
  type = map(string)
}
