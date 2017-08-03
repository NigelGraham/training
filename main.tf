provider "aws" {
  #  region     = "eu-west-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"

terraform {
  backend "atlas" {
    name = "NigelGraham/training"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

resource "aws_instance" "web" {
  ami                    = "ami-b87299c1"
  instance_type          = "t2.micro"
  count                  = "3"
  subnet_id              = "subnet-f0e85097"
  vpc_security_group_ids = ["sg-b2a021ca"]

  tags {
    "Identity" = "Idol=training-stork"
    "name"     = "Nigel Graham"
    "company"  = "theidol.com"
    "index"    = "${count.index}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

output "index" {
  value = "${aws_instance.web.*.tags.index}"
}
