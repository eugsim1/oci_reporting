#!/bin/bash
### cd where you have put all the scripts any the yml file of the project
cd YOUR_DIRECTORY_WITH_ALL_YML_FILE
export LOCAL_DIR=PATH_TO_CURRENT_DIRECTORY_WHERE_THIS_SCRIPT_IS_LOCATED
export OCI_CLI_CONFIG_FILE="PATH TO YOUR oci cli config file" 
echo $OCI_CLI_CONFIG_FILE
export  OCI_CONFIG_PROFILE=DEFAULT
echo $OCI_CONFIG_PROFILE
export OCI_CONFIG_FILE="PATH TO YOUR oci cli config file" 
export REGION=eu-frankfurt-1
date_now=$(date +%m-%d-%y-%H-%M)
export tenancy_id="YOUR_TENANCY"
export region="eu-frankfurt-1"
export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook get_all_resources_teancy.yml  \
--extra-vars "tenancy_id=${tenancy_id}" \
--tags "check_db" \
--tags "dump-resources" \
--tags "get_info"

