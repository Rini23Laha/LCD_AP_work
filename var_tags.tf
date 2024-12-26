# Modify these tags suit project.

module teamtags {
  source      = "git::https://apsourcecontrol.visualstudio.com/AnalyticsBI/_git/terraform-module-aws-tags-team"
  owner       = "lahar"
  repo        = var.repo
  group       = "lcd"  #overide this @ resource with 'Group' if required
  description = "lcd"  #overide this @ resource with 'Description' if required
}



module gamedaytags {
  source          = "git::https://apsourcecontrol.visualstudio.com/Cloud%20Platform%20Enablement/_git/terraform-module-aws-tags?ref=v1.0.1"
  product_id      = "23381"
  environment     = var.environment_long
  smo_usage       = "EnterpriseDataLakeService"
  app_recovery    = "false"
  deployment_type = "New"
}

locals{
    tags=merge(
        module.teamtags.tags,
        module.gamedaytags.tags
    )
}