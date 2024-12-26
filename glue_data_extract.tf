# Scripts for Glue Jobs 

resource "aws_s3_bucket_object" "lcd_extract_data_script" {
  bucket = "ap-s3-gluescript${var.accountid}${local.ap_suffix}"
  key    = "lcd/extract/extract_interface.py"
  source = "${path.module}/scripts/extract/extract_interface.py"
  etag   = filemd5("${path.module}/scripts/extract/extract_interface.py")
}


#  Glue Job

resource "aws_glue_job" "lcd_extract_data" {
  name            = "ap-gluejob-lcd-data-extract${local.ap_suffix}"
  role_arn        = aws_iam_role.ap-role-lcd-service-glue.arn
  execution_class = "STANDARD"
  glue_version = "3.0"
  timeout = 60
  connections = [aws_glue_connection.lcd_network_connection.name] 
  max_capacity = 1
   tags = {
          Name        = "ap-gluejob-lcd-data-extract${local.ap_suffix}",
          Description = "Extract Data from API to convert it in parquet file and save it in Raw S3"
        }
 
  command {
    name            = "pythonshell"
    script_location = "s3://ap-s3-gluescript${var.accountid}${local.ap_suffix}/${aws_s3_bucket_object.lcd_extract_data_script.key}"
    python_version  = "3.9"
  }
  execution_property {
    max_concurrent_runs = 10
  
  }   

  default_arguments = {
    "--enable-glue-datacatalog"          = ""
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
    "--TempDir"                          = "s3://ap-s3-lakeraw${var.accountid}${local.ap_suffix}/glue_jobs_temporary/lcd/"
    "--additional-python-modules"        = "psycopg2"
    "--class"                            = "GlueApp"
    "--JOB_NAME"                         = "ap-pythonshell-extract${local.ap_suffix}"
    "--job-language"                     = "python"
    "--job-bookmark-option"              = "job-bookmark-disable"
    "--processed_bucket"                    = "ap-s3-lakeprocessed${var.accountid}${local.ap_suffix}"
    "--raw_bucket"                    = "ap-s3-lakeraw${var.accountid}${local.ap_suffix}"
    "--path_prefix"                      = "lcd/"
    "--lcd_api_host"                    = "${var.accountid == "772631637424" ? "https://airproducts-pilot.csod.com" : "https://airproducts.csod.com"}"
    "--secret_name"                      = aws_secretsmanager_secret.lcd_apisecret.name
    "--region_name"                      = "us-east-1"
    "--IS_VERBOSE_MODE"                  = "False"
    "--extra-py-files"                   = "s3://ap-s3-gluescript${var.accountid}${local.ap_suffix}/lcd/utility/commons-0.1-py2.py3-none-any.whl"
    "--library-set"                      = "analytics"
    "--no_concurrent_req"                = "2" 
    "--api_name"                         = ""
    "--is_full_load"                     = "True" 
    "--sns_arn"                          = "arn:aws:sns:${local.region_long}:${var.accountid}:${aws_sns_topic.lcd.name}"
    "--account_id"                       = "${var.accountid}"
    "--servicenow_sns_topic"             = "arn:aws:sns:us-east-1:462411030134:ap-topic-servicenow-inc"
    
  }
}

