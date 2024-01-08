variable "instance_names" {
  type = map
  default = {
    mongodb = "t3.small"
    redis = "t2.micro"
    mysql = "t3.small"
    web = "t2.small"
  }
}

variable "zone_id" {
  default = "Z05173601IP58I4SC18MS" # your zoin_id
}

variable "domain_name" {
  default = "devrobo.shop" # your domain name
}