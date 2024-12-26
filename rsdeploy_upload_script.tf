## Manifests
resource "aws_s3_bucket_object" "manifest" {
   for_each = fileset("${path.module}/scripts/redshift1/manifests/", "*.manifest")
   bucket = data.aws_s3_bucket.rsdeploy.id
   key    = "manifests/${each.value}"
   source = "${path.module}/scripts/redshift1/manifests/${each.value}"
   etag   = filemd5("${path.module}/scripts/redshift1/manifests/${each.value}")
}

resource "aws_s3_bucket_object" "source" {
    for_each = fileset("${path.module}/scripts/redshift1/sql/lcd/source/", "*.sql")
    bucket = data.aws_s3_bucket.rsdeploy.id
    key    = "sql/lcd/source/${each.value}"
    source = "${path.module}/scripts/redshift1/sql/lcd/source/${each.value}"
    etag   = filemd5("${path.module}/scripts/redshift1/sql/lcd/source/${each.value}")
 }


resource "aws_s3_bucket_object" "processed" {
    for_each = fileset("${path.module}/scripts/redshift1/sql/lcd/processed/", "*.sql")
    bucket = data.aws_s3_bucket.rsdeploy.id
    key    = "sql/lcd/processed/${each.value}"
    source = "${path.module}/scripts/redshift1/sql/lcd/processed/${each.value}"
    etag   = filemd5("${path.module}/scripts/redshift1/sql/lcd/processed/${each.value}")
 }

resource "aws_s3_bucket_object" "curated" {
    for_each = fileset("${path.module}/scripts/redshift1/sql/lcd/curated/", "*.sql")
    bucket = data.aws_s3_bucket.rsdeploy.id
    key    = "sql/lcd/curated/${each.value}"
    source = "${path.module}/scripts/redshift1/sql/lcd/curated/${each.value}"
    etag   = filemd5("${path.module}/scripts/redshift1/sql/lcd/curated/${each.value}")
 }
 ## EDC
 resource "aws_s3_bucket_object" "edc" {
    for_each = fileset("${path.module}/scripts/redshift1/sql/lcd/edc/", "*.sql")
    bucket = data.aws_s3_bucket.rsdeploy.id
    key    = "sql/lcd/edc/${each.value}"
    source = "${path.module}/scripts/redshift1/sql/lcd/edc/${each.value}"
    etag   = filemd5("${path.module}/scripts/redshift1/sql/lcd/edc/${each.value}")
 }