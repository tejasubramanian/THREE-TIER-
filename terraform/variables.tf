variable "cluster_name" {
  type    = string
  default = "my-eks-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.34"
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}
