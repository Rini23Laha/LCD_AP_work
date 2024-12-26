# Mandatory Declarations
  variable "accountid" {
    description = "target account"
  }

  variable "environment_long" {
    description = "Set in tfvars"
  }

  
  variable "repo" {
    type = string
    description = "Repository Name. Auto Populated by DevOps"
  }

variable "service_lcd_apisecret" {
    type = string
    description = "Populated from devOps Library"
    sensitive = true
  }
locals{
     timestamp = formatdate("YYYY-MMM-DD hh:mm:ss",timestamp())
}

variable "redshift_host" {
    type = string
    description = "redshift"
}

variable "service_lcd_api_id"{
  type =string
  description="populated from devops library"
}

variable "service_lcd_etl"{
  type =string
  description="populated from devops library"
}
