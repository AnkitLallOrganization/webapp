variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "source_ami" {
  type    = string
  default = "ami-0dfcb1ef8550277af" # Ubuntu 22.04 LTS
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "vpc_id" {
  type    = string
  default = "vpc-01276ec252f7960ce"
}

variable "subnet_id" {
  type    = string
  default = "subnet-051481c62c6ff86a6"
}

variable "deviceName" {
  type    = string
  default = "/dev/xvda"
}

variable "volSize" {
  type    = string
  default = 8
}

variable "volType" {
  type    = string
  default = "gp2"
}

variable "DBUSER" {
  type = string
}

variable "DBPASS" {
  type = string
}


variable "DBHOST" {
  type = string
}

variable "PORT" {
  type = string
}

variable "DBPORT" {
  type = string
}

variable "DATABASE" {
  type = string
}

variable "ami_users" {
  type    = list(string)
  default = ["891054375493", "680696435068"]
}

variable "instanceType" {
  type    = string
  default = "t2.micro"
}

variable "amiName" {
  type    = string
  default = "ami"
}

variable "amiDesc" {
  type    = string
  default = "AMI"
}

variable "amiRegions" {
  type    = list(string)
  default = ["us-east-1"]
}

source "amazon-ebs" "app-ami" {
  region          = "${var.aws_region}"
  ami_name        = "${var.amiName}-${timestamp()}"
  ami_description = "${var.amiDesc}"
  ami_users       = "${var.ami_users}"
  ami_regions = "${var.amiRegions}"

  aws_polling {
    delay_seconds = 120
    max_attempts  = 50
  }


  instance_type = "${var.instanceType}"
  source_ami    = "${var.source_ami}"
  ssh_username  = "${var.ssh_username}"
  subnet_id     = "${var.subnet_id}"
  vpc_id        = "${var.vpc_id}"

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "${var.deviceName}"
    volume_size           = var.volSize
    volume_type           = "${var.volType}"
  }
}

build {
  sources = ["source.amazon-ebs.app-ami"]

  provisioner "file" {
    source      = "../webapp"
    destination = "/home/ec2-user/webapp.zip"
  }

  provisioner "shell" {
    // environment_vars = [
    //   "DEBIAN_FRONTEND=noninteractive",
    //   "CHECKPOINT_DISABLE=1"
    // ]

    script           = "packer/webapp.sh"
    environment_vars = ["DBUSER=${var.DBUSER}", "DBPASS=${var.DBPASS}", "DBHOST=${var.DBHOST}", "PORT=${var.PORT}", "DATABASE=${var.DATABASE}", "DBPORT=${var.DBPORT}"]

  }
}