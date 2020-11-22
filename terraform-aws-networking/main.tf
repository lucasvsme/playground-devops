terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.0"
    }
  }
}

variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "playground_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group_rule" "playground_sgr" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.playground_vpc.cidr_block]
  security_group_id = aws_security_group.playground_sg.id
}

resource "aws_security_group" "playground_sg" {
  name   = "allow_http"
  vpc_id = aws_vpc.playground_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.playground_vpc.cidr_block]
  }
}

resource "aws_subnet" "playground_subnet" {
  vpc_id     = aws_vpc.playground_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_network_acl" "playground_acl" {
  vpc_id = aws_vpc.playground_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }
  subnet_ids = [aws_subnet.playground_subnet.id]
}
