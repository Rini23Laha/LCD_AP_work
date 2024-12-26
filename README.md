# Introduction 
Ingest the TRRT data into data lake, this data helps measure the efficiency of the agents in call center and more value is derived when this data is joined with LBShell lblogistrpt_eu.processed.segment and lblogistrpt_eu.processed.customerprofile tables

- Requirements
https://approd.sharepoint.com/:w:/r/sites/DataManagement/Data%20Architecture/Projects/EDL%20TRRT%20(WREQ0015027)/TRRT%20Functional%20Specification.docx?d=wba21585537ae41df8aba4b38a94e9c34&csf=1&web=1&e=zTGHlf

- TSA
https://approd.sharepoint.com/:w:/r/sites/Architecture/Technical%20Summary/TRRT_EDL_TSA.docx?d=w4f45887e0bf8405cafc2957ba4504263&csf=1&web=1&e=mbeddN

- Vendor API Documentation: https://develop.clink.cn/develop/api/cc.html#_%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E

cd
# Package details
    -  scripts
        -   extract         - Contains the extract code for glue jobs 
        -   transform       - Contains the transformation code
        -   configs         - Contains all the constants, api attributes and Redshift table field mappings for each api 
        -   load            - Contains the script to load the data into redshift DB
        -   redshift        - Contains the SQL files to create the tables and views in redshift and manifest files 
        -   utilities       - Contains utility functions used by extract and transform scripts
        -   dist            - Contains the zip and whl files consumed by the extract, load jobs
                            **Note: Need to replace the commons-0.1-py2.py3-none-any.whl files incase if there are any changes in the python scripts, steps to replace this file mentioned under # Step to build the commons library for the glue job**                           
    -  *.tf                 - Teffraform scritps 

# Contribute
In order add any new APIs into the pipeline
-   create the file under extract ,transform, redshift and configs for the new api as per the naming conventions
-   -   extract
        -   Similar to any other api extract file set the request type, headers, params and call the function "call_api" to extract the data
    -   transform
        -   Define all the transformation and return the pandas dataframe
    -   configs
        -   Define all the mapping between API attributes and Redshift column names
        -   Add the line for the new API in table_unique_field list - this is required to identify each record uniquely
    -   Redshift
        -  Add the sql files for the new api, add the table create statement with proper data types
    - once changes are done, please follow the deployment steps mentioned below


# Deployment
-   Make necessary changes as described in # Contribute
-   Step to build the commons library for the glue job
    -   cd scripts
    -   ```python setup.py bdist_wheel --universal```
    -   A file with name 'commons-0.1-py2.py3-none-any.whl' created under the dist directory
-   Commit and push
- Trigger the build in Azure Devops
Note:
-   This step need to performed for any code changes apart sql file updates
