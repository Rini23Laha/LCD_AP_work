resource "aws_s3_bucket_object" "commons_whl_lib" {
  bucket = data.aws_s3_bucket.gluescript.id
  key    = "lcd/utility/commons-0.1-py2.py3-none-any.whl"
  source = "${path.module}/scripts/dist/commons-0.1-py2.py3-none-any.whl"
  etag = filemd5("${path.module}/scripts/dist/commons-0.1-py2.py3-none-any.whl")
}