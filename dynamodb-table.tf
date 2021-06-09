module "dynamodb_table" {
  source           = "terraform-aws-modules/dynamodb-table/aws"
  version          = ">= 1.1.0"
  name             = var.dynamodb_table_name
  hash_key         = "ID"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  server_side_encryption_enabled = true
  attributes = [{
    name = "ID"
    type = "S"
  }]
}
