# secret instance
resource "aws_secretsmanager_secret" "lcd_apisecret" {
  name                    = "${local.environment_3}/lcd/apisecret"
  policy                  = data.aws_iam_policy_document.lcd_policy_apisecret.json
  recovery_window_in_days = 0
  tags = {
    Name        = "${local.environment_3}/lcd/apisecret"
    Description = "lcd Token to authenticate api call"
  }
}

# set secret value
resource aws_secretsmanager_secret_version "lcd_apisecret_version" {
  secret_id     = aws_secretsmanager_secret.lcd_apisecret.id
  secret_string = jsonencode(local.apisecret_json)
}

# convert secret string to JSON
variable "apisecret_json" {
  type    = map(string)
  default = {}
}
locals {
  apisecret_json = merge(
    var.apisecret_json,
    {
      access_id = var.service_lcd_api_id
      access_secret = var.service_lcd_apisecret
    }
  )
}

data aws_iam_policy_document "lcd_policy_apisecret" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        aws_iam_role.ap-role-lcd-service-glue.arn,
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