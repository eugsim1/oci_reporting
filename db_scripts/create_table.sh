#!/bin/bash
# Check if at least two parameters are provided
if [[ $# -lt 1 ]]; then
    echo "ERROR: Not enough arguments provided!"
    echo "Usage: $0 <param1> <param2>"
    exit 1
fi

export PARAM1="$1" ## database 
export PARAM2="$2" ## service to connect
export PARAM3="$3" ## usere
export PARAM4="$4" ## password

export ORAENV_ASK=NO
export ORACLE_SID=${PARAM1}
. /usr/local/bin/oraenv

echo $ORACLE_HOME

sqlplus ${PARAM3}/${PARAM4}@${PARAM2}<<EOF
-- Create table if not exists
BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE resource_extraction_log (
    resource_type    VARCHAR2(100),
    identifier       VARCHAR2(200),
    compartment_id   VARCHAR2(200),
    lifecycle_state  VARCHAR2(50),
    time_created     DATE,
    defined_tags     CLOB,
    current_date     DATE DEFAULT SYSDATE
)';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN  -- ORA-00955: name is already used by an existing object
         NULL;  -- Table already exists, do nothing
      ELSE
         RAISE;  -- Raise other unexpected errors
      END IF;
END;
/
EOF


sqlplus ${PARAM3}/${PARAM4}@${PARAM2}<<EOF
CREATE TABLE resource_extraction_history AS 
SELECT * FROM resource_extraction_log WHERE 1=0;
EOF
