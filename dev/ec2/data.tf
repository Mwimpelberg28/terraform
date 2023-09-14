data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["dev-vpc-public-us-west-2a"]
  }
}

data "aws_vpc" "dev" {
  tags = {
    Name = "dev-vpc"
  }
}
