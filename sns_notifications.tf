#Rule for event pattern

resource "aws_cloudwatch_event_rule" "lcd_exceptions_rule" {
    name        = "ap-evrl-lcd-fail${local.ap_suffix}"
    description = "Event pattern processing lcd workflow fail"
    event_pattern = <<EOF
    {
      "source": ["aws.glue"],
      "detail-type": ["Glue Job State Change"],
      "detail": {
        "severity": ["ERROR"],
        "state": ["FAILED", "ERROR", "STOPPED","TIMEOUT"],
        "jobName": [
            "${aws_glue_job.lcd_extract_data.name}",
            "${aws_glue_job.lcd_data_load.name}"
        ]
      }
    }
EOF

    tags =  {
        Name = "ap-evrl-lcdfail${local.ap_suffix}"
        Description = "EventBridge rule to catch stats of lcd Exceptions table"  
    }
}


resource "aws_cloudwatch_event_target" "lcd_sns" {
  rule      = aws_cloudwatch_event_rule.lcd_exceptions_rule.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.lcd.arn
}

resource "aws_sns_topic" "lcd" {
  name = "lcd_topic"
}


resource "aws_sns_topic_policy" "lcd_default" {
  arn    = aws_sns_topic.lcd.arn
  policy = data.aws_iam_policy_document.lcd_sns_topic_policy.json
}

data "aws_iam_policy_document" "lcd_sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.lcd.arn]
  }
}

resource "aws_sns_topic_subscription" "lcd_email_target" {
  for_each  = toset(["lahar@airproducts.com"]) ## TODO: Replace email with Team DL
  topic_arn = aws_sns_topic.lcd.arn
  protocol  = "email"
  endpoint  = each.value
}