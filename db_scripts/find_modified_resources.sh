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

sqlplus ${PARAM3}/${PARAM4}@${PARAM2}<<EOF

SELECT h.identifier, h.lifecycle_state AS old_state, r.lifecycle_state AS new_state
FROM resource_extraction_history h
JOIN resource_extraction_log r
ON h.identifier = r.identifier
WHERE h.lifecycle_state <> r.lifecycle_state;
EOF
