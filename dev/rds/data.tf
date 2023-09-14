data "aws_subnet" "private1" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc-private-us-west-2a"]
  }
}

data "aws_subnet" "private2" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc-private-us-west-2b"]
  }
}

data "aws_vpc" "dev" {
  tags = {
    Name = "dev-vpc"
  }
}
