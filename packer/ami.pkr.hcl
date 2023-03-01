variable "aws_access_key" {
  type    = string
  default = "AKIA2SLQTYCUL2V37XFN"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_secret_key" {
  type    = string
  default = "lkC8ChMPRRRAKU5wHST+bjbtBiR9+6SYjz3SF2M6"
}

data "amazon-ami" "awsdev-ami" {
  access_key = "${var.aws_access_key}"
  filters = {
    name                = "amzn2-ami-hvm-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
  region      = "${var.aws_region}"
  secret_key  = "${var.aws_secret_key}"
}

source "amazon-ebs" "ami" {
  access_key    = "${var.aws_access_key}"
  ami_name      = "webapp"
  ami_users     = [640375653027]
  instance_type = "t2.micro"
  region        = "${var.aws_region}"
  secret_key    = "${var.aws_secret_key}"
  source_ami    = "${data.amazon-ami.awsdev-ami.id}"
  ssh_username  = "ec2-user"
  tags = {
    Name = "AMI"
  }
}

build {
  sources = ["source.amazon-ebs.ami"]

  provisioner "shell" {
    inline = ["sudo mkdir -p /home/ec2-user/scripts", "sudo chown -R ec2-user:ec2-user /home/ec2-user/scripts", "sudo chmod -R 755 /home/ec2-user/scripts"]
  }

  

  provisioner "file" {
    destination = "/home/ec2-user/webapp.zip"
    source      = "../webapp.zip"
  }

  provisioner "file" {
    destination = "/home/ec2-user/scripts/postgres.sh"
    source      = "tmp/postgres.sh"
  }

  provisioner "file" {
    destination = "/home/ec2-user/scripts/node.sh"
    source      = "tmp/node.sh"
  }
  provisioner "file" {
    destination = "/tmp/node.service"
    source      = "../service/node.service"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/node.service /etc/systemd/system/node.service", "sudo systemctl daemon-reload", "sudo systemctl enable node.service", "sudo systemctl start node.service"]
  }

  provisioner "shell" {
    inline = ["sudo chmod o+x /home/ec2-user/scripts/node.sh", "sudo /home/ec2-user/scripts/node.sh", "sudo chmod o+x /home/ec2-user/scripts/postgres.sh", "sudo /home/ec2-user/scripts/postgres.sh"]
  }

  provisioner "shell" {
    inline = ["rpm -Va --nofiles --nodigest"]
  }

