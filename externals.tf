############################################################################################################################
# Use this file to declare references to resources that exist outside of this Repository
############################################################################################################################


# SSO Role References 
############################################################################################################################
# Purpose: Provides references to pre-defined SSO Roles that we see in the console
  
     module ssoprincipals {
        source = "git::https://apsourcecontrol.visualstudio.com/AnalyticsBI/_git/terraform-module-aws-ssoprincipals"
        accountid = var.accountid
        as_strings = true
        as_resources = true
    }

# Bucket for glue scripts
############################################################################################################################
data "aws_s3_bucket" "gluescript" {
  bucket = "ap-s3-gluescript${var.accountid}${local.ap_suffix}"
}

# RDeploy bucket repository for SQL Scripts & manifests:
############################################################################################################################
data "aws_s3_bucket" "rsdeploy" {
  bucket = "ap-s3-rsdeploy${var.accountid}${local.ap_suffix}"
}

# Allow RSDepoy to retreive secret.
# .. create R/S user with this password
data "aws_iam_role" "rsdeploy" {
    name = "ap-role-rsdeploy${local.environment_short}"
}