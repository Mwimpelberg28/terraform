resource "aws_instance" "web" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t3.micro"
  ebs_block_device {
    device_name = "xvdb"
    volume_type = "gp3"
    volume_size = 10
    encrypted   = true
  }
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 8
  type              = "gp3"

  tags = {
    Name = "HelloWorld"
  }
}
