terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
}

resource "aws_security_group" "ssh_sg_tf" {
 name        = "ssh"
 description = "Allow ssh to bastion server"
 vpc_id      = "vpc-0ec62b52a6bf2a916"

ingress {
   description = "SSH ingress"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  associate_public_ip_address = true
  name = "single-instance"
  ami = "ami-03f65b8614a860c29"
  instance_type          = "t3.micro"
  key_name               = "macbookpro"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ssh_sg_tf.id]
  subnet_id              = "subnet-02bd495c0eeed8c23"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}