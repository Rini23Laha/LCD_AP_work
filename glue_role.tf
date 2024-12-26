
# Declare role to to attach to glue jobs

data "aws_iam_policy_document" "assumeglue" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["glue.amazonaws.com"]
      type        = "Service"
    }
  }
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "ap-role-lcd-service-glue" {
    name               = "ap-role-lcd-service-glue${local.environment_short}"
    assume_role_policy = data.aws_iam_policy_document.assumeglue.json
    
     tags = {
        Name        = "ap-role-lcd-service-glue${local.environment_short}",
        Description = "Glue Role for lcd-service"
      }
}

resource "aws_iam_role_policy" "lcd-servicegluepolicy" {
          name      = "ap-plcy-lcd-service${local.environment_short}"
          role      = aws_iam_role.ap-role-lcd-service-glue.id
          policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "GlueToReadObjectinS3",
			"Effect": "Allow",
			"Action": [
				"s3:GetObject",
				"s3:GetObjectAcl",
				"s3:ListBucket",
				"s3:ListBucketMultipartUploads",
				"s3:AbortMultipartUpload",
				"s3:ListMultipartUploadParts",
				"s3:GetBucketLocation",
				"s3:GetBucketAcl",
        "s3:RestoreObject",
        "kms:Encrypt",
				"kms:Decrypt"
			],
			"Resource": [
				"arn:aws:s3:::ap-s3-lakeraw${var.accountid}${local.ap_suffix}/lcd/*",
        "arn:aws:s3:::ap-s3-lakeraw${var.accountid}${local.ap_suffix}/lcd",
				"arn:aws:s3:::ap-s3-lakeprocessed${var.accountid}${local.ap_suffix}/lcd/*",
        "arn:aws:s3:::ap-s3-lakeprocessed${var.accountid}${local.ap_suffix}/lcd",
				"arn:aws:s3:::ap-s3-gluescript${var.accountid}${local.ap_suffix}/*",
        "arn:aws:s3:::ap-s3-lakeraw${var.accountid}${local.ap_suffix}/glue_jobs_temporary/lcd/*"
			]
		},
		{ 
			"Effect": "Allow",
            "Action": [
                "glue:*",
                "lakeformation:GetDataAccess"
            ],
            "Resource": [
                "*"
            ]
        },
		{
			"Sid": "GlueToPlaceObjectinS3",
			"Effect": "Allow",
			"Action": [
        "s3:CopyObject",
				"s3:PutObject",
				"s3:PutObjectAcl",
				"s3:DeleteObject",
        "s3:RestoreObject"
			],
			"Resource": [
        "arn:aws:s3:::ap-s3-lakeprocessed${var.accountid}${local.ap_suffix}/lcd",
				"arn:aws:s3:::ap-s3-lakeprocessed${var.accountid}${local.ap_suffix}/lcd/*",
				"arn:aws:s3:::ap-s3-lakeraw${var.accountid}${local.ap_suffix}/lcd/*",
        "arn:aws:s3:::ap-s3-lakeraw${var.accountid}${local.ap_suffix}/lcd",
				"arn:aws:s3:::ap-s3-gluescript${var.accountid}${local.ap_suffix}/lcd/*",
        "arn:aws:s3:::ap-s3-lakeraw${var.accountid}${local.ap_suffix}/glue_jobs_temporary/lcd/*"

			]
		},		
     { 
    "Effect": "Allow",
          "Action": [
              "kms:GenerateDataKey*",
              "kms:Decrypt"
          ],
          "Resource": [             
              "arn:aws:kms:us-east-1:462411030134:key/*"
          ]
    },
    {        
      "Sid": "GlueToDynamodb",    
      "Effect" : "Allow",
      "Action" : [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DescribeTable",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
      ],
      "Resource" : [
        "arn:aws:dynamodb:${local.region_long}:${var.accountid}:table/lcd_exceptions",
        "arn:aws:dynamodb:${local.region_long}:${var.accountid}:table/lcd_data_extraction_checkpoint"
      ]
    },
		{
      "Sid": "PassRolePermissions",
      "Effect": "Allow",
      "Action": [
          "iam:PassRole"
      ],
      "Resource": [
          "${aws_iam_role.ap-role-lcd-service-glue.arn}"
      ]
    }
	]
}
EOF
}
        
resource "aws_iam_role_policy_attachment" "glue_service" {
        role       = aws_iam_role.ap-role-lcd-service-glue.name
        policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
      }



resource "aws_iam_role_policy_attachment" "glue_cloudwatch" {
        role       = aws_iam_role.ap-role-lcd-service-glue.name
        policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
      }
