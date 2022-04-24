IF OBJECT_ID ('austin') IS NOT NULL 
DROP TABLE austin 
GO 

CREATE TABLE austin 
(
finished_year_DC varchar (100),	
PER_CD	varchar (100),
department_CD	varchar (100),
department_name	varchar (100),
fund_CD	varchar (100),
fund_name	varchar (100),
division_CD	varchar (100),
division_name	varchar (100),
section_CD	varchar (100),
section_name	varchar (100),
OCAT_CD	varchar (100),
OCAT_NM	varchar (100),
object_CD	varchar (100),
object_name	varchar (100),
legal_name	varchar (100),
VEND_CUST_CD	varchar(100),
VEND_CUST_IND	varchar (100),
RFED_DOC_CD	varchar (100),
RFED_DOC_DEPT_CD	varchar (100),
RFED_DOC_ID	varchar (100),
commodity_CD	varchar (100),
commodity_desc	varchar (100),
check_issue_date	DATE,
check_status_DV	varchar (100),
RFED_VEND_LN_NO	varchar (100),
RFED_COMM_LN_NO	varchar (100),
RFED_ACTG_LN_NO	varchar (100),
RF_DOC_CD	varchar (100),
RF_DOC_DEPT_CD	varchar (100),
RF_DOC_ID	varchar (100),
actual_desc	varchar (100),
AMOUNT	varchar (100),
CAL_YEAR	varchar (100),
CAL_MONTH	varchar (100),

-- first thing need to do is to adjust datatypes and make sure that data is easy to understand 
--old names were FY_DC	PER_CD	DEPT_CD	DEPT_NM	FUND_CD	FUND_NM	DIV_CD	DIV_NM	GP_CD	GP_NM	
--				OCAT_CD	OCAT_NM	OBJ_CD	OBJ_NM	LGL_NM	VEND_CUST_CD	VEND_CUST_IND	RFED_DOC_CD	RFED_DOC_DEPT_CD	
--				RFED_DOC_ID	COMM_CD	COMM_DSCR	CHK_EFT_ISS_DT	CVL_CHK_STA_DV	RFED_VEND_LN_NO	RFED_COMM_LN_NO	
--				RFED_ACTG_LN_NO	RF_DOC_CD	RF_DOC_DEPT_CD	RF_DOC_ID	ACTG_LN_DSCR	AMOUNT	CAL_YEAR	CAL_MONTH
)
BULK INSERT austin 
FROM 'C:\Users\ibrah\OneDrive\Documents\random\CASE STUDIES\Austin\Fiscal_Year_2009_eCheckbook_Payments.csv'
WITH( DATAFILETYPE = 'char',
FIRSTROW = 2 ,
FIELDTERMINATOR = '|' ,
ROWTERMINATOR =  '0x0A'
) 
-- had to change the delimiter in the csv files because the address columns included commas

BULK INSERT austin 
FROM 'C:\Users\ibrah\OneDrive\Documents\random\CASE STUDIES\Austin\Fiscal_Year_2010_eCheckbook_Payments.csv'
WITH( DATAFILETYPE = 'char',
FIRSTROW = 2 ,
FIELDTERMINATOR = '|' ,
ROWTERMINATOR =  '0x0A'
) 

BULK INSERT austin 
FROM 'C:\Users\ibrah\OneDrive\Documents\random\CASE STUDIES\Austin\Fiscal_Year_2011_eCheckbook_Payments.csv'
WITH( DATAFILETYPE = 'char',
FIRSTROW = 2 ,
FIELDTERMINATOR = '|' ,
ROWTERMINATOR =  '0x0A'
) 
BULK INSERT austin 
FROM 'C:\Users\ibrah\OneDrive\Documents\random\CASE STUDIES\Austin\Fiscal_Year_2012_eCheckbook_Payments.csv'
WITH( DATAFILETYPE = 'char',
FIRSTROW = 2 ,
FIELDTERMINATOR = '|' ,
ROWTERMINATOR =  '0x0A'
) 
BULK INSERT austin 
FROM 'C:\Users\ibrah\OneDrive\Documents\random\CASE STUDIES\Austin\Fiscal_Year_2013_eCheckbook_Payments.csv'
WITH( DATAFILETYPE = 'char',
FIRSTROW = 2 ,
FIELDTERMINATOR = '|' ,
ROWTERMINATOR =  '0x0A'
) 
GO 

Select * 
from austin 