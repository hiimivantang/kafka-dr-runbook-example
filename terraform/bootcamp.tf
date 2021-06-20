variable "region" {
  default = "ap-southeast-1"
}

variable "availability-zone" {
  default = "ap-southeast-1b"
}

variable "owner" {
  default = "itang"
}

variable "key-name" {
  default = "ivantang-aws-sg"
}

variable "zk-count" {
  default = 6
}

variable "broker-count" {
  default = 6
}

variable "connect-count" {
  default = 1
}

variable "schema-count" {
  default = 1
}

variable "rest-count" {
  default = 0
}

variable "c3-count" {
  default = 2
}

variable "ksql-count" {
  default = 0
}

// instance types

locals {
  zk-instance-type = "t3a.large"
  broker-instance-type = "t3a.large"
  schema-instance-type = "t3a.large"
  connect-instance-type = "t3a.large"
  rest-instance-type = "t3a.large"
  c3-instance-type = "t3a.large"
  ksql-instance-type = "t3a.large"
  client-instance-type = "t3a.large"
}

// Provider

provider "aws" {
  profile    = "default"
  region     = var.region
}

variable "aws-ami-id"  {
  default = "ami-05e6476d77d9dfce2"
}

variable "linux-user" {
  default = "ec2-user"
}

variable "vpc-id" {
  default = "vpc-0f2bcda0bdc15bb14"
}

variable "subnet-id" {
  default = "subnet-05d3a6370a7913514"
}

variable "vpc-security-group-ids" {
  default = ["sg-097d329ab8712d0c9"]
}


// Resources

resource "aws_instance" "zookeepers" {
  count         = var.zk-count
  ami           = var.aws-ami-id
  instance_type = local.zk-instance-type
  availability_zone = var.availability-zone
  key_name = var.key-name

  tags = {
    Name = "${var.owner}-zookeeper-${count.index}-${var.availability-zone}"
    description = "zookeeper nodes - Managed by Terraform"
    role = "zookeeper"
    zookeeperid = count.index
    owner = var.owner
    sshUser = var.linux-user
    region = var.region
    role_region = "zookeepers-${var.region}"
  }

  subnet_id = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = true
}

resource "aws_instance" "brokers" {
  count         = var.broker-count
  ami           = var.aws-ami-id
  instance_type = local.broker-instance-type
  availability_zone = var.availability-zone
  # security_groups = ["${var.security_group}"]
  key_name = var.key-name
  root_block_device {
    volume_size = 1000 # 1TB
  }
  tags = {
    Name = "${var.owner}-broker-${count.index}-${var.availability-zone}"
    description = "broker nodes - Managed by Terraform"
    nice-name = "kafka-${count.index}"
    big-nice-name = "follower-kafka-${count.index}"
    brokerid = count.index
    role = "broker"
    owner = var.owner
    sshUser = var.linux-user
    # sshPrivateIp = true // this is only checked for existence, not if it's true or false by terraform.py (ati)
    createdBy = "terraform"
    # ansible_python_interpreter = "/usr/bin/python3"
    #EntScheduler = "mon,tue,wed,thu,fri;1600;mon,tue,wed,thu;fri;sat;0400;"
    region = var.region
    role_region = "brokers-${var.region}"
  }

  subnet_id = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = true
}

resource "aws_instance" "connect-cluster" {
  count         = var.connect-count
  ami           = var.aws-ami-id
  instance_type = local.connect-instance-type
  availability_zone = var.availability-zone
  key_name = var.key-name
  tags = {
    Name = "${var.owner}-connect-${count.index}-${var.availability-zone}"
    description = "Connect nodes - Managed by Terraform"
    role = "connect"
    Owner = var.owner
    sshUser = var.linux-user
    region = var.region
    role_region = "connect-${var.region}"
  }

  subnet_id = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = true
}

resource "aws_instance" "schema" {
  count         = var.schema-count
  ami           = var.aws-ami-id
  instance_type = local.schema-instance-type
  availability_zone = var.availability-zone
  key_name = var.key-name
  tags = {
    Name = "${var.owner}-schema-${count.index}-${var.availability-zone}"
    description = "Schema nodes - Managed by Terraform"
    role = "schema"
    Owner = var.owner
    sshUser = var.linux-user
    region = var.region
    role_region = "schema-${var.region}"
  }

  subnet_id = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = true
}

resource "aws_instance" "control-center" {
  count         = var.c3-count
  ami           = var.aws-ami-id
  instance_type = local.c3-instance-type
  availability_zone = var.availability-zone
  key_name = var.key-name
  tags = {
    Name = "${var.owner}-control-center-${count.index}-${var.availability-zone}"
    description = "Control Center nodes - Managed by Terraform"
    role = "c3"
    Owner = var.owner
    sshUser = var.linux-user
    region = var.region
    role_region = "c3-${var.region}"
  }

  subnet_id = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = true
}

resource "aws_instance" "rest" {
  count         = var.rest-count
  ami           = var.aws-ami-id
  instance_type = local.rest-instance-type
  availability_zone = var.availability-zone
  key_name = var.key-name
  tags = {
    Name = "${var.owner}-rest-${count.index}-${var.availability-zone}"
    description = "Rest nodes - Managed by Terraform"
    role = "rest"
    Owner = var.owner
    sshUser = var.linux-user
    region = var.region
    role_region = "rest-${var.region}"
  }

  subnet_id = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = true
}

resource "aws_instance" "ksql" {
  count         = var.ksql-count
  ami           = var.aws-ami-id
  instance_type = local.ksql-instance-type
  availability_zone = var.availability-zone
  key_name = var.key-name
  tags = {
    Name = "${var.owner}-ksql-${count.index}-${var.availability-zone}"
    description = "Rest nodes - Managed by Terraform"
    role = "schema"
    Owner = var.owner
    sshUser = var.linux-user
    region = var.region
    role_region = "schema-${var.region}"
  }

  subnet_id = var.subnet-id
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = true
}

// Output

output "zookeeper_public_dns" {
  value = [aws_instance.zookeepers.*.public_dns]
}

output "broker_public_dns" {
  value = [aws_instance.brokers.*.tags.brokerid,aws_instance.brokers.*.public_dns]
}

output "connect_public_dns" {
  value = [aws_instance.connect-cluster.*.public_dns]
}

output "schema_public_dns" {
  value = [aws_instance.schema.*.public_dns]
}

output "control_center_public_dns" {
  value = [aws_instance.control-center.*.public_dns]
}

output "rest_public_dns" {
  value = [aws_instance.rest.*.public_dns]
}

output "ksql_public_dns" {
  value = [aws_instance.ksql.*.public_dns]
}
