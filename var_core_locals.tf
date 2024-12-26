# Standard set of locals to use in code as required
# No changes to this code required for different accounts

# The following will be available to the rest of your code
    # region_long              # e.g. 'use-east-1'
    # region_short             # e.g. 'use'
    # environment_long         # e.g. 'Development'
    # environment_short        # e.g. '-tch' '-dev', '' (blank for PROD)
    # environment_short_athena # e.g. '_tch' '_dev', '' (blank for PROD)
    # environment_3            # e.g. 'tch' 'dev' '' !!!!! this should be blank for paths etc (secret)
    # ap_suffix                # e.g. '-use-tch', '-use-dev', '-use'  (non-IAM resources)
    #                                                                 .. use environment_short for IAM (no region)
    # ap_suffix_athena         # e.g.  '_use_tch', '_use-dev', '_use' (ATHENA resources)


# Code
locals{
    ap_suffix = "-${local.region_short}${local.environment_short}"
    ap_suffix_athena = replace(local.ap_suffix,"-","_")
}

# R e g i o n 
    data "aws_region" "current" {}
    locals{
        region_long = data.aws_region.current.name
    }

    module region {
      source = "git::https://apsourcecontrol.visualstudio.com/Cloud%20Platform%20Enablement/_git/terraform-module-aws-region?ref=v1.0.0"
      region = local.region_long
    }

    locals{
      region_short = module.region.region_abbrev
    } 

# E n v i r o n m e n t 
    
    # Returns suffix WITH LEADING HYPHEN
    module environment {
      source      = "git::https://apsourcecontrol.visualstudio.com/Cloud%20Platform%20Enablement/_git/terraform-module-aws-environment?ref=v1.0.0"
      environment = var.environment_long
    }

    locals{
      environment_short = module.environment.environment_abbrev
      environment_3 = replace(local.environment_short,"-","")
    } 
    locals{
      environment_short_athena = replace(module.environment.environment_abbrev,"-","_")
    } 