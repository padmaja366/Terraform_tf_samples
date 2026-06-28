#using hardcoded vpc, subnets and security groups
provider "aws" {
  region = "ap-southeast-1"
}
data "aws_vpc" "example" {
  filter {
    name = "vpc-id"
    values = [ "████████████████████" ]
  }
}
data "aws_subnet" "public-subnet-example" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.example.id]
  }
  filter {
    name = "subnet-id"
    values = [ "████████████████████" ]
  }
}
resource "aws_launch_template" "example" {
  image_id = "ami-041fd2572c7575386"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ "████████████████████" ]
  key_name = "██████████"
}
resource "aws_autoscaling_group" "demoASG" {
  launch_template {
    id = aws_launch_template.example.id
  }
  vpc_zone_identifier = [data.aws_subnet.public-subnet-example.id]
  min_size = 2
  max_size = 10
  tag {
    key = "Name"
    value = "terraform_asg_example"
    propagate_at_launch = true
  }
}
