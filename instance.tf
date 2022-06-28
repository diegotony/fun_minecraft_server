module "server" {
  source          = "git::https://github.com/diegotony/aws_ec2_instance.git?ref=v1.3.0"
  security_groups = ["${aws_security_group.this.name}"]
  key_name        = "terraform"
  name            = var.name
  user_data       = <<EOF
    #! /bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello world  from $(hostname -f) </h1>" > /var/www/html/index.html
    sudo rpm --import https://yum.corretto.aws/corretto.key
    sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
    sudo yum install -y java-17-amazon-corretto-devel.x86_64
    java --version
    sudo adduser minecraft
    sudo su
    mkdir -p /opt/minecraft/server
    cd /opt/minecraft/server
    wget ${var.minecraft_server_url}
    sudo chown -R minecraft:minecraft /opt/minecraft/
    echo "eula=true" >> eula.txt
    echo "${file("${path.module}/src/config/minecraft.service")}" >> "/etc/systemd/system/minecraft.service"
    chmod 664 /etc/systemd/system/minecraft.service
    systemctl daemon-reload
    java -Xmx1024M -Xms1024M -jar /opt/minecraft/server/server.jar nogui
  EOF
  tags = var.tags

}
