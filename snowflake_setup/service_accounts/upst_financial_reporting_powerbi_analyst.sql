//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// reporting warehouse
CREATE WAREHOUSE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH
    COMMENT='Warehouse for powering analytics queries from PowerBI for the UPSTeam Financial Reporting project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access (OA) roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA roles
CREATE ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_OWNER;
CREATE ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to OA roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA privileges
GRANT OWNERSHIP ON WAREHOUSE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH TO ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_OWNER;
GRANT USAGE ON WAREHOUSE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH     TO ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function (BF) roles and grant access to OA roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST;

// grant all roles to sysadmin (always do this)
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;

// OA role assignment
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_OWNER TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_USAGE TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ     TO ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST;
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH_USAGE TO ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST;
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_SERVICE_ACCOUNT_USER
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for connecting PowerBI to Snowflake for UPSTeam Financial Reporting analytics.'
  DEFAULT_WAREHOUSE = UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_WH
  DEFAULT_ROLE = UPST_FINANCIAL_REPORTING_POWERBI_ANALYST
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE UPST_FINANCIAL_REPORTING_POWERBI_ANALYST TO USER UPST_FINANCIAL_REPORTING_POWERBI_ANALYST_SERVICE_ACCOUNT_USER;
//=============================================================================
