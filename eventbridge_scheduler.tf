resource "aws_cloudwatch_event_rule" "transcript_core" {
    name        = "ap-evrl-transcript_core${local.ap_suffix}"
    description = "Schedule transcript_core"
 
     schedule_expression = "cron(0 1 * * ? *)"
    #  is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-transcript_core${local.ap_suffix}"
        Description = "triggers transcript_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "transcript_core" {
  rule      = aws_cloudwatch_event_rule.transcript_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.transcript_core]
  arn = aws_glue_workflow.lcd_transcript_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
}
resource "aws_cloudwatch_event_rule" "ou_core" {
    name        = "ap-evrl-ou_core${local.ap_suffix}"
    description = "Schedule ou_core"
 
     schedule_expression = "cron(02 1 * * ? *)"
    #  is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-ou_core${local.ap_suffix}"
        Description = "triggers ou_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "ou_core" {
  rule      = aws_cloudwatch_event_rule.ou_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.ou_core]
  arn = aws_glue_workflow.lcd_ou_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "user_ou_core" {
    name        = "ap-evrl-user_ou_core${local.ap_suffix}"
    description = "Schedule user_ou_core"
 
     schedule_expression = "cron(04 1 * * ? *)"
    # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-user_ou_core${local.ap_suffix}"
        Description = "triggers user_ou_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "user_ou_core" {
  rule      = aws_cloudwatch_event_rule.user_ou_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.user_ou_core]
  arn = aws_glue_workflow.lcd_user_ou_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "training_core" {
    name        = "ap-evrl-training_core${local.ap_suffix}"
    description = "Schedule training_core"
 
     schedule_expression = "cron(06 1 * * ? *)"
      # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-training_core${local.ap_suffix}"
        Description = "triggers training_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "training_core" {
  rule      = aws_cloudwatch_event_rule.training_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.training_core]
  arn = aws_glue_workflow.lcd_training_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "training_cf_core" {
    name        = "ap-evrl-training_cf_core${local.ap_suffix}"
    description = "Schedule training_cf_core"
 
     schedule_expression = "cron(08 1 * * ? *)"
      # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-training_cf_core${local.ap_suffix}"
        Description = "triggers training_cf_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "training_cf_core" {
  rule      = aws_cloudwatch_event_rule.training_cf_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.training_cf_core]
  arn = aws_glue_workflow.lcd_training_cf_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "training_local_core" {
    name        = "ap-evrl-training_local_core${local.ap_suffix}"
    description = "Schedule training_local_core"
 
     schedule_expression = "cron(10 1 * * ? *)"
      # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-training_local_core${local.ap_suffix}"
        Description = "triggers training_local_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "training_local_core" {
  rule      = aws_cloudwatch_event_rule.training_local_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.training_local_core]
  arn = aws_glue_workflow.lcd_training_local_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "transcript_status_local_core" {
    name        = "ap-evrl-transcript_status_local_core${local.ap_suffix}"
    description = "Schedule transcript_status_local_core"
 
     schedule_expression = "cron(12 1 * * ? *)"
      # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-transcript_status_local_core${local.ap_suffix}"
        Description = "triggers transcript_status_local_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "transcript_status_local_core" {
  rule      = aws_cloudwatch_event_rule.transcript_status_local_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.transcript_status_local_core]
  arn = aws_glue_workflow.lcd_transcript_status_local_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "address_core" {
    name        = "ap-evrl-address_core${local.ap_suffix}"
    description = "Schedule address_core"
 
     schedule_expression = "cron(14 1 * * ? *)"
      # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-address_core${local.ap_suffix}"
        Description = "triggers address_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "address_core" {
  rule      = aws_cloudwatch_event_rule.address_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.address_core]
  arn = aws_glue_workflow.lcd_address_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "curriculum_core" {
    name        = "ap-evrl-curriculum_core${local.ap_suffix}"
    description = "Schedule curriculum_core"
 
     schedule_expression = "cron(16 1 * * ? *)"
      # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-curriculum_core${local.ap_suffix}"
        Description = "triggers curriculum_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "curriculum_core" {
  rule      = aws_cloudwatch_event_rule.curriculum_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.curriculum_core]
  arn = aws_glue_workflow.lcd_curriculum_structure_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}
resource "aws_cloudwatch_event_rule" "users_core" {
    name        = "ap-evrl-users_core${local.ap_suffix}"
    description = "Schedule users_core"
 
     schedule_expression = "cron(18 1 * * ? *)"
      # is_enabled = (var.accountid == "772631637424") ? true : false 
    tags =  {
        Name = "ap-evrl-users_core${local.ap_suffix}"
        Description = "triggers users_core glue workflow once in a day"  
    }
}
 
resource "aws_cloudwatch_event_target" "users_core" {
  rule      = aws_cloudwatch_event_rule.users_core.name
  target_id = "1"
  depends_on = [aws_cloudwatch_event_rule.users_core]
  arn = aws_glue_workflow.lcd_users_core_data_extract_wf.arn
  role_arn = aws_iam_role.ap-role-lcd-service-glue.arn
 
}

