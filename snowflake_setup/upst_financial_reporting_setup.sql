//=============================================================================
// create data resources
//=============================================================================
USE ROLE SYSADMIN;

// Databases
CREATE DATABASE UPST_FINANCIAL_REPORTING_DEV;
CREATE DATABASE UPST_FINANCIAL_REPORTING_TEST;
CREATE DATABASE UPST_FINANCIAL_REPORTING_PROD;

// schemas
CREATE SCHEMA UPST_FINANCIAL_REPORTING_PROD.ANALYTICS;
//=============================================================================


//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// dev warehouse
CREATE WAREHOUSE UPST_FINANCIAL_REPORTING_DEVELOPER_WH
  COMMENT='Warehouse for powering data engineering activities for the UPSTeam financial reporting project'
  WAREHOUSE_SIZE=XSMALL
  AUTO_SUSPEND=60
  INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access (OA) roles
//=============================================================================
USE ROLE SECURITYADMIN;

// data access
CREATE ROLE UPST_FINANCIAL_REPORTING_DEV_OWNER;
CREATE ROLE UPST_FINANCIAL_REPORTING_DEV_WRITE;
CREATE ROLE UPST_FINANCIAL_REPORTING_DEV_READ;
CREATE ROLE UPST_FINANCIAL_REPORTING_TEST_OWNER;
CREATE ROLE UPST_FINANCIAL_REPORTING_TEST_WRITE;
CREATE ROLE UPST_FINANCIAL_REPORTING_TEST_READ;
CREATE ROLE UPST_FINANCIAL_REPORTING_PROD_OWNER;
CREATE ROLE UPST_FINANCIAL_REPORTING_PROD_WRITE;
CREATE ROLE UPST_FINANCIAL_REPORTING_PROD_READ;
CREATE ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ;

// warehouse access
CREATE ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_OWNER;
CREATE ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_ALL_PRIVILEGES;

// grant all roles to sysadmin (always do this)
GRANT ROLE UPST_FINANCIAL_REPORTING_DEV_OWNER                   TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEV_WRITE                   TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEV_READ                    TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_OWNER                  TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_WRITE                  TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_READ                   TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_OWNER                  TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_WRITE                  TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_READ                   TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ         TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_OWNER          TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_ALL_PRIVILEGES TO ROLE SYSADMIN;
//=============================================================================
 

//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// data access
GRANT OWNERSHIP ON DATABASE UPST_FINANCIAL_REPORTING_DEV                                    TO ROLE UPST_FINANCIAL_REPORTING_DEV_OWNER;
GRANT USAGE, CREATE SCHEMA ON DATABASE UPST_FINANCIAL_REPORTING_DEV                         TO ROLE UPST_FINANCIAL_REPORTING_DEV_WRITE;
GRANT USAGE ON DATABASE UPST_FINANCIAL_REPORTING_DEV                                        TO ROLE UPST_FINANCIAL_REPORTING_DEV_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE UPST_FINANCIAL_REPORTING_DEV                      TO ROLE UPST_FINANCIAL_REPORTING_DEV_READ;
GRANT OWNERSHIP ON DATABASE UPST_FINANCIAL_REPORTING_TEST                                   TO ROLE UPST_FINANCIAL_REPORTING_TEST_OWNER;
GRANT USAGE, CREATE SCHEMA ON DATABASE UPST_FINANCIAL_REPORTING_TEST                        TO ROLE UPST_FINANCIAL_REPORTING_TEST_WRITE;
GRANT USAGE ON DATABASE UPST_FINANCIAL_REPORTING_TEST                                       TO ROLE UPST_FINANCIAL_REPORTING_TEST_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE UPST_FINANCIAL_REPORTING_TEST                     TO ROLE UPST_FINANCIAL_REPORTING_TEST_READ;
GRANT OWNERSHIP ON DATABASE UPST_FINANCIAL_REPORTING_PROD                                   TO ROLE UPST_FINANCIAL_REPORTING_PROD_OWNER;
GRANT USAGE, CREATE SCHEMA ON DATABASE UPST_FINANCIAL_REPORTING_PROD                        TO ROLE UPST_FINANCIAL_REPORTING_PROD_WRITE;
GRANT OWNERSHIP ON SCHEMA UPST_FINANCIAL_REPORTING_PROD.ANALYTICS                           TO ROLE UPST_FINANCIAL_REPORTING_PROD_WRITE;
GRANT USAGE ON DATABASE UPST_FINANCIAL_REPORTING_PROD                                       TO ROLE UPST_FINANCIAL_REPORTING_PROD_READ;
GRANT USAGE ON FUTURE SCHEMAS IN DATABASE UPST_FINANCIAL_REPORTING_PROD                     TO ROLE UPST_FINANCIAL_REPORTING_PROD_READ;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ                                     TO ROLE UPST_FINANCIAL_REPORTING_PROD_READ;
GRANT USAGE ON DATABASE UPST_FINANCIAL_REPORTING_PROD                                       TO ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ;
GRANT USAGE ON SCHEMA UPST_FINANCIAL_REPORTING_PROD.ANALYTICS                               TO ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ;
GRANT SELECT ON FUTURE TABLES IN SCHEMA UPST_FINANCIAL_REPORTING_PROD.ANALYTICS             TO ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA UPST_FINANCIAL_REPORTING_PROD.ANALYTICS              TO ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ;
GRANT SELECT ON FUTURE MATERIALIZED VIEWS IN SCHEMA UPST_FINANCIAL_REPORTING_PROD.ANALYTICS TO ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ;

// warehouse access
GRANT OWNERSHIP ON WAREHOUSE UPST_FINANCIAL_REPORTING_DEVELOPER_WH      TO ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_OWNER;
GRANT ALL PRIVILEGES ON WAREHOUSE UPST_FINANCIAL_REPORTING_DEVELOPER_WH TO ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_ALL_PRIVILEGES;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
// BF roles
CREATE ROLE UPST_FINANCIAL_REPORTING_ADMIN;
CREATE ROLE UPST_FINANCIAL_REPORTING_DEVELOPER;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE UPST_FINANCIAL_REPORTING_ADMIN     TO ROLE SYSADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEVELOPER TO ROLE SYSADMIN;

// grant bf roles to admin roles
GRANT ROLE UPST_FINANCIAL_REPORTING_DEVELOPER TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;

// grant OA roles
GRANT ROLE UPST_FINANCIAL_REPORTING_DEV_OWNER                    TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEV_WRITE                    TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEV_READ                     TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_OWNER                   TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_WRITE                   TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_READ                    TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_OWNER                   TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_WRITE                   TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_READ                    TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_ANALYTICS_READ          TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_OWNER          TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_ALL_PRIVILEGES TO ROLE UPST_FINANCIAL_REPORTING_ADMIN;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEV_WRITE                   TO ROLE UPST_FINANCIAL_REPORTING_DEVELOPER;
GRANT ROLE UPST_FINANCIAL_REPORTING_TEST_READ                   TO ROLE UPST_FINANCIAL_REPORTING_DEVELOPER;
GRANT ROLE UPST_FINANCIAL_REPORTING_PROD_READ                   TO ROLE UPST_FINANCIAL_REPORTING_DEVELOPER;
GRANT ROLE UPST_FINANCIAL_REPORTING_DEVELOPER_WH_ALL_PRIVILEGES TO ROLE UPST_FINANCIAL_REPORTING_DEVELOPER;

// Grant pre-existing source read roles here
//=============================================================================