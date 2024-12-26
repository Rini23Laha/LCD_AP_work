resource "aws_glue_connection" "lcd_redshift_connection" {
  
  name = "ap_glue_lcd_redshift_connection"
  connection_type = "JDBC"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:redshift://${var.redshift_host}:5439/lcd"
    PASSWORD            = var.service_lcd_etl
    USERNAME            = "service_lcd_etl"
    JDBC_ENFORCE_SSL    = "true"
  }
  physical_connection_requirements {
    availability_zone       = data.aws_subnet.subnet_glue.availability_zone
    security_group_id_list  = [data.aws_security_group.lcd_redshift_sec_grp.id]
    subnet_id               =data.aws_subnet.subnet_glue.id
  }
  
}


data "aws_subnet" "lcd_subnet_b" {
  id = data.terraform_remote_state.vpc.outputs.private_subnet_ids[1]
}

data "aws_security_group" "lcd_redshift_sec_grp" {
    name = "ap-sg-qdiredshift${local.ap_suffix}"
}


data "aws_subnet" "subnet_glue"{
  filter{
    name = "tag:Name"
    values = ["ap-subn-private-glue"]
  }
}

# VPC Endpoint for S3


data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "ap-s3-terraform-use" # - use, use2, sg, de, dr, dev-sbx
    key            = "${var.accountid}/reference/network/terraform.tfstate"
    region         = local.region_long          ##- us-east-1, ap-southeast-1, eu-central-1, us-east-2
    dynamodb_table = "ap-dyn-terraform-use" ##- use, use2, sg, de, dr
  }
}
