resource "aws_instance" "web" {
  ami           = "ami-03265a0778a880afb" #devops-practice
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop-all.id]  
  tags = {
    Name = "provisioner"
  }
  provisioner "local-exec" {
    command = "echo this is will execute at the time of creation, you can trigger other system sending mail and alert"
  }

  provisioner "local-exec" {
    #command = "echo the server is${self.private_ip}"
        command = "echo ${self.private_ip} > inventory"
    }
  # provisioner "local-exec" {
  #      command = "ansible-playbook -i inventory web.yaml"
  # }
   provisioner "local-exec" {
    when = destroy
    command = "echo this will execute at the time of destroy, you can trigger other system sending mail and alert"
  } 

  connection {
    type    = "ssh"
    user    = "root"
    password = "DevOps321"
    host    = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
        "echo 'this is from remote exec' > /tmp/remote.txt",
        "sudo yum install nginx -y",
        "sudo systemctl start nginx"
    ]
  }
}

resource "aws_security_group" "roboshop-all" { #this is terraform name, for terraform reference only
    name        = "provisioner" # this is for AWS
   

    ingress {
        description      = "Allow All ports"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
        description      = "Allow All ports"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    tags = {
        Name = "provisioner-all"
    }
}