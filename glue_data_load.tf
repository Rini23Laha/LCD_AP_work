resource "aws_s3_bucket_object" "lcd_data_load" {
   bucket = "ap-s3-gluescript${var.accountid}${local.ap_suffix}"
   key    = "lcd/lcd_data_load.py"
   source = "${path.module}/scripts/load/lcd_data_load.py"  
   etag   = filemd5("${path.module}/scripts/load/lcd_data_load.py")
}


#  Glue Job
resource "aws_glue_job" "lcd_data_load" {
    name     = "ap-gluejob-lcd-data-load${local.ap_suffix}"

    role_arn =aws_iam_role.ap-role-lcd-service-glue.arn
    glue_version = "3.0"
    number_of_workers = "2"
    timeout = 30
    worker_type = "G.1X"
    # max_retries = 1
    connections = [aws_glue_connection.lcd_redshift_connection.name]
     tags = {
          Name        = "ap-gluejob-lcd-data-load${local.ap_suffix}",
          Description = "Reads parquet from S3 processed layer and load to redshift"
        }
  command {
    script_location = "s3://ap-s3-gluescript${var.accountid}${local.ap_suffix}/${aws_s3_bucket_object.lcd_data_load.key}"
    python_version  = "3"
  }
   
  execution_property {
    max_concurrent_runs = 10
  }

  default_arguments = {
     "--enable-glue-datacatalog" = ""
     "--enable-continuous-cloudwatch-log" = "true"
     "--enable-continuous-log-filter"     = "true"
     "--enable-metrics"            = ""
     "--temp_path"                 = "s3://ap-s3-lakeraw${var.accountid}${local.ap_suffix}/glue_jobs_temporary/lcd/"
     "--additional-python-modules" = "psycopg2"
     "--class"                     = "GlueApp"
     "--JOB_NAME"                  = "ap-gluejob-lcd-data-load${local.ap_suffix}"
     "--job-language"              = "python"
     "--job-bookmark-option"       = "job-bookmark-enable"
     "--processed_bucket"          = "ap-s3-lakeprocessed${var.accountid}${local.ap_suffix}"
     "--raw_bucket"                = "ap-s3-lakeraw${var.accountid}${local.ap_suffix}"
     "--DATABASE_NAME"             = "ap_gldb_lf_raw_lcd${local.ap_suffix_athena}"
     "--IS_VERBOSE_MODE"           = "False"
     "--library-set"               = "analytics"
     "--path_prefix"               = "lcd/"
     "--spark-event-logs-path"     = "s3://ap-s3-gluescript${var.accountid}${local.ap_suffix}/lcd/sparkHistoryLogs/"
     "--extra-py-files"            = "s3://ap-s3-gluescript${var.accountid}${local.ap_suffix}/lcd/utility/commons-0.1-py2.py3-none-any.whl"
     "--sns_arn"                  = "arn:aws:sns:${local.region_long}:${var.accountid}:${aws_sns_topic.lcd.name}"
      "--env"                      = var.environment_long
      "--redshift_role"            = "arn:aws:iam::${var.accountid}:role/ap-role-qdi-redshift${local.environment_short}"
      "--account_id"               = "${var.accountid}"
      "--servicenow_sns_topic"     = "arn:aws:sns:us-east-1:462411030134:ap-topic-servicenow-inc"
      "--region_name"              = "${local.region_long}"
      "--enable-auto-scaling"      = "true"       
     }
}
