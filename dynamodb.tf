resource "aws_dynamodb_table" "lcd_data_extraction_checkpoint" {
  name           = "lcd_data_extraction_checkpoint"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "api_name" 

  attribute {
    name = "api_name"
    type = "S"
  }

  tags = {
    Name        = "lcd_data_extraction_checkpoint"
    Description = "Keeps track of the time upto which data is extracted for the given API"  
    Environment = var.environment_long
  }
}
resource "aws_dynamodb_table" "lcd_exceptions-dynamodb-table" {
  name           = "lcd_exceptions"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "exception"

  attribute {
    name = "exception"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  global_secondary_index {
    name               = "exceptionIndex"
    hash_key           = "exception"
    projection_type    = "INCLUDE"
    non_key_attributes = ["updatedtime"]
  }

  tags = {
    Name        = "lcd_exceptions"
    Environment = "${var.environment_long}"
  }
}