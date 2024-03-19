resource "aws_key_pair" "terraform_keys" {
  key_name   = "terraform_keys"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "UAT_1" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.uat-pub-1.id
  key_name               = aws_key_pair.terraform_keys.key_name
  vpc_security_group_ids = [aws_security_group.uat_stack_sg.id]
  tags = {
    Name    = "UAT_Instance"
    Project = "OnPrem Migration"
  }


  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod u+x /tmp/web.sh",
      "sed -i $'s/[^[:print:]\t]//g' /tmp/web.sh",
      "sudo sh /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("terraform_keys")
    host        = self.public_ip
  }
}

resource "aws_ebs_volume" "vol_4_UAT1" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "extr-vol-4-uat"
  }
}

resource "aws_volume_attachment" "atch_vol_uat" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol_4_UAT1.id
  instance_id = aws_instance.UAT_1.id
}

output "PublicIP" {
  value = aws_instance.UAT_1.public_ip
}
