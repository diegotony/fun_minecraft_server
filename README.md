# tf-module
Template

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_attact_policy"></a> [create\_attact\_policy](#module\_create\_attact\_policy) | git::https://github.com/diegotony/aws_policy.git | first_version |
| <a name="module_lambda_mc_shutdown"></a> [lambda\_mc\_shutdown](#module\_lambda\_mc\_shutdown) | git::https://github.com/diegotony/aws_lambda_function.git | v1.1.0 |
| <a name="module_lambda_mc_start"></a> [lambda\_mc\_start](#module\_lambda\_mc\_start) | git::https://github.com/diegotony/aws_lambda_function.git | v1.1.0 |
| <a name="module_server"></a> [server](#module\_server) | git::https://github.com/diegotony/aws_ec2_instance.git | v1.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | give a description | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | fun\_minecraft name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_egress"></a> [egress](#input\_egress) | n/a | <pre>map(object({<br>    description = string<br>    from_port   = string<br>    to_port     = string<br>    protocol    = string<br>    cidr_blocks = any<br>    allow       = string<br>    type        = string<br>  }))</pre> | <pre>{<br>  "default": {<br>    "allow": "true",<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "default",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0,<br>    "type": "egress"<br>  }<br>}</pre> | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | n/a | <pre>map(object({<br>    description = string<br>    from_port   = string<br>    to_port     = string<br>    protocol    = string<br>    cidr_blocks = any<br>    allow       = string<br>    type        = string<br>  }))</pre> | <pre>{<br>  "http-80": {<br>    "allow": "true",<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow port 80 from VPC",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80,<br>    "type": "ingress"<br>  },<br>  "minecraft": {<br>    "allow": "true",<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow port 25565 from VPC",<br>    "from_port": 25565,<br>    "protocol": "tcp",<br>    "to_port": 25565,<br>    "type": "ingress"<br>  },<br>  "ssh-22": {<br>    "allow": "true",<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow port 22 from VPC",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "to_port": 22,<br>    "type": "ingress"<br>  }<br>}</pre> | no |
| <a name="input_minecraft_server_url"></a> [minecraft\_server\_url](#input\_minecraft\_server\_url) | (optional) describe your variable | `string` | `"https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->