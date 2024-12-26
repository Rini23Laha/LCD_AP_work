resource "aws_glue_workflow" "lcd_ou_core_data_extract_wf" {
  name = "lcd_ou_core_data_extract_wf"
  max_concurrent_runs = 10
   tags = {
           Name        = "lcd_ou_core_data_extract_wf",
           Description = "Glue Workflow to trigger extract and load for ou_core_data_extract_wf "
          }
  default_run_properties = {
    "api_name" = "ou_core"      
   }
}

resource "aws_glue_trigger" "lcd_ou_core_data_extract_pythonshell" {
  name          = "trigger-lcd_ou_core_data_extract_pythonshell"
  type          = "EVENT"
  workflow_name = aws_glue_workflow.lcd_ou_core_data_extract_wf.name
   tags = {
          Name        = "trigger-lcd_ou_core_data_extract_pythonshell_job",
          Description = "To trigger data extract Job for ou_core Instance"
        }
  
  actions {
    job_name = aws_glue_job.lcd_extract_data.name
    
  }
}
resource "aws_glue_trigger" "lcd_ou_core_data_load_to_redshift" {
  name          = "verify_lcd_ou_core_data_extract_succeeded"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.lcd_ou_core_data_extract_wf.name
   tags = {
          Name        = "verify_lcd_ou_core_data_extract_succeeded",
          Description = "Verify data extraction from ou_core api is sucessfull"
        }

  predicate { 
    conditions {
      job_name = aws_glue_job.lcd_extract_data.name
      state    = "SUCCEEDED"
    }
  }


  actions {
    job_name = aws_glue_job.lcd_data_load.name
     
  }
}