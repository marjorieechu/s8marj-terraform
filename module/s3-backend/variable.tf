variable "aws_region_source" {
  type    = string
}

variable "aws_region_backup" {
  type    = string
}

variable "force_destroy" {
  type    = bool
}

variable "common_tags" {
  type = map(any)
}