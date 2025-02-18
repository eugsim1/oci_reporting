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


sqlldr {{ db_user }}/{{ db_password }}@{{ db_host }}/{{ db_service }}
        control={{ control_file }} log=/opt/logs/resource_loader.log

LOAD DATA
INFILE '/opt/data/resource_data.csv'
INTO TABLE resource_extraction_log
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(
    resource_type    CHAR,
    identifier       CHAR,
    compartment_id   CHAR,
    lifecycle_state  CHAR,
    time_created     DATE "YYYY-MM-DD HH24:MI:SS",
    defined_tags     CHAR,
    current_date     SYSDATE
)
