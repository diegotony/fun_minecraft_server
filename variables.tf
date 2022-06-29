variable "minecraft_server_url" {
    type = string
    default = "https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar"
    description = "Minecraft server URl (1.19 for default)"
}

variable "name" {
  type        = string
  description = "Server name"
}

variable "description" {
  type        = string
  description = "Give a description to Server"
  default = "Just Survive"
}

variable "ingress" {
  description = "Inbound Config"
  type = map(object({
    description = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_blocks = any
    allow       = string
    type        = string
  }))

  default = {
    ssh-22 = {
      description = "Allow port 22 from VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      type        = "ingress"
    },
    http-80 = {
      description = "Allow port 80 from VPC"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      "type"      = "ingress"
    },

    minecraft = {
      description = "Allow port 25565 from VPC"
      from_port   = 25565
      to_port     = 25565
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      "type"      = "ingress"
    }
  }
}

variable "egress" {
  description = "Outbound Config"
  type = map(object({
    description = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_blocks = any
    allow       = string
    type        = string
  }))

  default = {
    default = {
      description = "default"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      type        = "egress"

    }
  }
}

variable "tags" {
  description = "tags"
  type = map
  default = {"Environment" = "minecraft-server", "created-by" = "terraform", "owner" = "Notch"}
}