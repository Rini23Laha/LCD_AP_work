#Resource to upload pipeline info csv file to S3
resource "aws_s3_bucket_object" "pipeline_info" {
   bucket = "ap-s3-lakeraw${var.accountid}${local.ap_suffix}"
   key    = "edl_dash/lcd_pipeline_info.csv"
   source = "${path.module}/scripts/configs/lcd_pipeline_info.csv"
   etag   = filemd5("${path.module}/scripts/configs/lcd_pipeline_info.csv")  
}
