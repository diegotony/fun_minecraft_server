module "lambda_mc_start" {
  source          = "git::https://github.com/diegotony/aws_lambda_function.git?ref=v1.1.0"
  source_dir    = "${path.module}/src/functions/mc_start"
  function_name = "${var.name}-mc_start"
  runtime       = "nodejs14.x"
  handler       = "index.handler"
  description   = var.description
  environment   = { INSTANCE_ID = module.server.id }
  
}

module "lambda_mc_shutdown" {
  source          = "git::https://github.com/diegotony/aws_lambda_function.git?ref=v1.1.0"
  source_dir    = "${path.module}/src/functions/mc_shutdown"
  function_name = "${var.name}-mc_shutdown"
  runtime       = "nodejs14.x"
  handler       = "index.handler"
  description   = var.description
  schedule_expression = "rate(20 minutes)"
  environment   = { INSTANCE_ID = module.server.id , MAX_HOURS = "6"}
  
}


module "create_attact_policy" {
  source    = "git::https://github.com/diegotony/aws_policy.git?ref=first_version"
  actions   = ["ec2:*"]
  resources = ["arn:aws:ec2:*"]
  name      = "${var.name}-ec2FullAccess"
  role      = module.lambda_mc_shutdown.lambda_exec_name
}

