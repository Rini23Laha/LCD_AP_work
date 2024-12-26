resource "aws_glue_connection" "lcd_network_connection" {
  
  name = "ap_glue_lcd_network_connection"
  connection_type = "NETWORK"
 
  physical_connection_requirements {
    availability_zone       = data.aws_subnet.subnet_glue.availability_zone
   security_group_id_list  = [data.aws_security_group.lcd_redshift_sec_grp.id]
    subnet_id               =data.aws_subnet.subnet_glue.id
  }
  
}