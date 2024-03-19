variable "REGION" {
  default = "us-east-2"
}

variable "ZONE1" {
  default = "us-east-2a"
}

variable "ZONE2" {
  default = "us-east-2b"
}

variable "ZONE3" {
  default = "us-east-2c"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-2 = "ami-0e0bf53f6def86294"
    us-east-1 = "ami-0947d2ba12ee1ff75"
  }
}

variable "USER" {
  default = "ec2-user"
}

variable "PUB_KEY" {
  default = "terraform_keys.pub"
}

variable "PRIV_KEY" {
  default = "terraform_keys"
}

variable "MYIP" {
  default = "103.221.74.29/32"
}
