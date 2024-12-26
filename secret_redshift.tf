# secret instance
resource "aws_secretsmanager_secret" "redshift" {
  name                    = "${local.environment_3}/redshift/service_lcd_etl"
  policy                  = data.aws_iam_policy_document.redshift.json
  recovery_window_in_days = 0
  #depends_on = [time_sleep.secret_sleep]

  tags = {
    Name        = "${local.environment_3}/redshift/service_lcd_etl"
    Description = "Redshift Creds for lcd Project"
  }
}

# set secret value
resource aws_secretsmanager_secret_version "redshift" {
  secret_id     = aws_secretsmanager_secret.redshift.id
  secret_string = jsonencode(local.redshift_json)
  
}

# convert secret string to JSON
variable "redshift_json" {
  type    = map(string)
  default = {}
}
locals {
  redshift_json = merge(
    var.redshift_json,
    {
      username = "service_lcd_etl"
      password = var.service_lcd_etl
    }
  )
}

data aws_iam_policy_document "redshift" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        data.aws_iam_role.rsdeploy.arn,
        module.ssoprincipals.role_resources["APDataLakeEngineer"].arn
      ]
      type  = "AWS"
    }
    actions = [
      "secretsmanager:GetSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:ListSecrets"
    ]
    resources = ["*"]
  }
}