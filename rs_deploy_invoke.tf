###########################################################################
# Deploying 2 x manifests 
#
# User manifest
# Object manifest
#
###########################################################################


# Deploy users manifest
# ------------------------------------
    locals{
      rsdeploy_users_json = jsonencode(
          {
          "manifest":"lcd_users.manifest",          # creates DB users via qdidatalake DB
          "home_environment":"${local.environment_short}",
          "host":"ap-qdi-redshift-dl${local.ap_suffix}"
          }
      )
    }

    resource "aws_lambda_invocation" "invo_users" {
        function_name = "ap-fun-rsdeploy${local.ap_suffix}"
        input = local.rsdeploy_users_json

        triggers = {
            now= local.timestamp   # ensures lambda invokes each Terraform APPLY
        }
        depends_on = [
          aws_s3_bucket_object.manifest
        ]
    }


# Deploy objects manifest
# ------------------------------------

locals{
    rsdeploy_object_json = jsonencode(
      {
        "manifest":"lcd_objects.manifest",             
        "home_environment":"${local.environment_short}",
        "host":"ap-qdi-redshift-dl${local.ap_suffix}"
        }
    )
  }
resource "aws_lambda_invocation" "invoke_objects" {
    function_name = "ap-fun-rsdeploy${local.ap_suffix}"
    input = local.rsdeploy_object_json

    triggers = {
        now= local.timestamp
    }
    depends_on = [
      aws_lambda_invocation.invo_users,
      aws_s3_bucket_object.source,
      aws_s3_bucket_object.processed,
      aws_s3_bucket_object.curated


    ]
}
## EDC schema
    locals{
    edc_json = jsonencode(
          {
          "manifest":"lcd_edc_objects.manifest",
          "home_environment":"${local.environment_short}",
          "host":"ap-qdi-redshift-dl${local.ap_suffix}"
          }
      )
    }
    resource "aws_lambda_invocation" "edc" {
        function_name = "ap-fun-rsdeploy${local.ap_suffix}"
        input = local.edc_json
        depends_on = [
          aws_s3_bucket_object.manifest
          
        ]
        triggers = {
            now =local.timestamp
        }
    }
