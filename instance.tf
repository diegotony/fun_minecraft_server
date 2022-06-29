module "server" {
  source          = "git::https://github.com/diegotony/aws_ec2_instance.git?ref=main"
  security_groups = ["${aws_security_group.this.name}"]
  key_name        = "terraform"
  name            = var.name
  instance_type   = "t2.small"
  user_data       = <<EOF
    #! /bin/bash
    sudo su 
    yum update -y
    echo "Check HTTP"
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello world  from $(hostname -f) </h1>" > /var/www/html/index.html
    echo "Minecraft server"
    rpm --import https://yum.corretto.aws/corretto.key
    curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
    java --version
    yum install -y java-17-amazon-corretto-devel.x86_64
    adduser minecraft
    mkdir -p /opt/minecraft/server
    cd /opt/minecraft/server
    wget ${var.minecraft_server_url}
    chown -R minecraft:minecraft /opt/minecraft/
    echo "${file("${path.module}/src/config/minecraft.service")}" >> "/etc/systemd/system/minecraft.service"
    chmod 664 /etc/systemd/system/minecraft.service
    systemctl daemon-reload
    cd /opt/minecraft/server && java -Xmx1024M -Xms1024M -jar server.jar nogui
    cd /opt/minecraft/server && sed -i 's/false/true/g' eula.txt
    cd /opt/minecraft/server && java -Xmx1024M -Xms1024M -jar server.jar nogui
  EOF
  tags = var.tags

}