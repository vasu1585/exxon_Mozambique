//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// warehouses
CREATE WAREHOUSE UPST_FINANCIAL_REPORTING_DBT_TEST_WH
    COMMENT='Warehouse for powering CI test activities for the UPSTeam Financial Reporting project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// OA roles
CREATE ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_OWNER;
CREATE ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_OWNER TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// OA privileges
GRANT OWNERSHIP ON WAREHOUSE UPST_FINANCIAL_REPORTING_DBT_TEST_WH TO ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_OWNER;
GRANT USAGE ON WAREHOUSE UPST_FINANCIAL_REPORTING_DBT_TEST_WH     TO ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
CREATE ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_ROLE;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_ROLE TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_ROLE TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;

// test OA roles
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_OWNER TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_USAGE TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_WRITE        TO ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_ROLE;
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_WH_USAGE TO ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_ROLE;

// grant source read roles here
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_USER
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the test (TEST) environment of the UPSTeam Financial Reporting project.'
  DEFAULT_WAREHOUSE = UPST_FINANCIAL_REPORTING_DBT_TEST_WH
  DEFAULT_ROLE = UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_ROLE
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_ROLE TO USER UPST_FINANCIAL_REPORTING_DBT_TEST_SERVICE_ACCOUNT_USER;
//=============================================================================
