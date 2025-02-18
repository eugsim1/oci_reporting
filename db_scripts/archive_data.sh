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
SET SERVEROUTPUT ON;

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM resource_extraction_log;
    
    IF v_count > 0 THEN
        INSERT INTO resource_extraction_history
        SELECT * FROM resource_extraction_log;

        DELETE FROM resource_extraction_log;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('History archived and current table cleared.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No data to archive.');
    END IF;
END;
/
EXIT;
EOF
