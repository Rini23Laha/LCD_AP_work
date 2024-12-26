# Scripts for Glue Jobs 


resource "aws_s3_bucket_object" "lcd_historical_data_ingestion" {
  bucket = "ap-s3-gluescript${var.accountid}${local.ap_suffix}"
  key    = "lcd/scripts/lcd_historical_data_ingestion.py"
  source = "${path.module}/scripts/lcd_historical_data_ingestion.py"
  etag   = filemd5("${path.module}/scripts/lcd_historical_data_ingestion.py")
}



#  Glue Job
resource "aws_glue_job" "lcd_glue_historical_data_ingestion" {
  name            = "ap-gluejob-lcd-historical-data-ingestion${local.ap_suffix}"
  role_arn        = aws_iam_role.ap-role-lcd-service-glue.arn
  execution_class = "STANDARD"
  glue_version = "3.0"
   tags = {
          Name        = "ap-gluejob-lcd-historical-data-ingestion${local.ap_suffix}",
          Description = "Extract Historical Data from the given API"
        }
  #number_of_workers = "10"
  #worker_type = "G.1X"
  command {
    name            = "pythonshell"
    script_location = "s3://ap-s3-gluescript${var.accountid}${local.ap_suffix}/${aws_s3_bucket_object.lcd_historical_data_ingestion.key}"
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
    "--temp_path"                        = "s3://ap-s3-lakeraw${var.accountid}${local.ap_suffix}/glue_jobs_temporary/lcd/"
    "--additional-python-modules"        = "psycopg2"
    "--class"                            = "GlueApp"
    "--JOB_NAME"                         = "ap-gluejob-lcd-historical-data-ingestion${local.ap_suffix}",
    "--job-language"                     = "python"
    "--job-bookmark-option"              = "job-bookmark-disable"
    "--target_bucket"                    = "ap-s3-lakeprocessed${var.accountid}${local.ap_suffix}"
    "--input_bucket"                     = "ap-s3-lakeraw${var.accountid}${local.ap_suffix}"
    "--input_bucket_prefix"              = "lcd/"
    "--region"                           = "${local.region_long}"
    "--IS_VERBOSE_MODE"                  = "False"
    "--library-set"                      = "analytics"
	  "--env"                              = "${var.environment_long}"
	  "--start_date"                       = ""
    "--end_date"                         = ""
	  "--is_extract_data"					         = "false"	
	  "--glue_workflow_name"				       = ""
    "--api_name"                         = ""
    # "--is_historical_data"              = "True"
    "--is_full_load_"                    =  "False"
    "--enable-auto-scaling"              = "True"
    
  }
}
