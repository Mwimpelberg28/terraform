terraform {
  # Intentionally empty. Will be filled by Terragrunt.
  backend "s3" {}
}


demodb.cw6h8tdckqd6.us-west-2.rds.amazonaws.com

resource "aws_security_group" "ssh_sg_tf" {
 name        = "ssh"
 description = "Allow ssh to bastion server"
 vpc_id      = data.aws_vpc.dev.id

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
  key_name               = "laptop"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ssh_sg_tf.id]
  subnet_id              = data.aws_subnet.public.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}