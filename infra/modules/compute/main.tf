resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.machine_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.instance_profile_name

  tags = {
    Name = var.instance_name
  }
}