module "lambda_function" {
  source             = "terraform-aws-modules/lambda/aws"
  version            = ">= 2.4.0"
  function_name      = "${var.dynamodb_table_name}-dynamodb-stream-processor"
  runtime            = "nodejs14.x"
  handler            = "index.handler"
  source_path        = "./lambda-function"
  attach_policies    = true
  number_of_policies = 2
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole"
  ]
  create_current_version_allowed_triggers = false
  allowed_triggers = { dynamodb = {
    principal  = "dynamodb.amazonaws.com"
    source_arn = module.dynamodb_table.dynamodb_table_stream_arn
  } }
  event_source_mapping = { dynamodb = {
    starting_position = "LATEST"
    event_source_arn  = module.dynamodb_table.dynamodb_table_stream_arn
  } }
}
