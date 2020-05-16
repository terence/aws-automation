# AWS Glue Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
EMR_CLUSTER_ID="xxx"

ATHENA_DATABASE="chicago"
ATHENA_WORKGROUP="primary"

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo ----------------------------------------------
echo 100 : AWS Athena Start Query Execution
echo 101 : AWS Athena Stop Query Execution
echo 102 : AWS Athena List Query Executions
echo 103 : AWS Athena Get Query Execution
echo 104 : AWS Athena Get Query Results
echo ----------------------------------------------
echo 110 : AWS Athena List Workgroups
echo 111 : AWS Athena Create Workgroups
echo 112 : AWS Athena Update Workgroup
echo 113 : AWS Athena Delete Workgroup
echo ----------------------------------------------
echo 120 : AWS Athena List Named Queries
echo 121 : AWS Athena Create Named [Saved] Query
echo 122 : AWS Ahtena Get Named [Saved] Query
echo 123 : AWS Ahtena Deleted Named [Saved] Query
echo ----------------------------------------------
echo 150 : AWS Athena Tag Resource
echo 151 : AWS Athena UnTag Resource
echo ----------------------------------------------
echo Enter [Selection] to continue
echo =============================================================

# Command line selection
if [ -n "$1" ]; then
  SELECTION=$1
else
  read  -n 3 SELECTION
fi

if [ -n "$2" ]; then
  PROFILE=$2
fi


echo Your selection is : $SELECTION.
echo Your profile is : $PROFILE.


case "$SELECTION" in
"001" )
  echo "===== AWS Configure - Setup"
  aws configure
  ;;


"002" )
  echo "===== AWS S3 List:" $PROFILE
  aws s3 ls --profile $PROFILE
  echo "Count:"
  aws s3 ls --profile $PROFILE | wc -l

  #aws s3 ls s3://bucketname
  #aws s3 cp
  # aws s3 sync local s3://remote
  ;;


"100" )
  echo "===== AWS Athena Start Query Execution:" $PROFILE
  aws athena start-query-execution \
		--query-string "select * from chicago" \
		--query-execution-context 'Database=chicago' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"101" )
  echo "===== AWS Athena Stop Query Execution:" $PROFILE
  aws athena stop-query-execution \
		#--query-execution-id \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"102" )
  echo "===== AWS Athena List Query Executions:" $PROFILE
  aws athena list-query-executions \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"103" )
  echo "===== AWS Athena Get Query Execution:" $PROFILE
  aws athena get-query-execution \
		--query-execution-id "085d0e8b-93b9-4288-a053-0cf149c751b7" \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"104" )
  echo "===== AWS Athena Get Query Results:" $PROFILE
  aws athena get-query-results \
		--query-execution-id "085d0e8b-93b9-4288-a053-0cf149c751b7" \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"110" )
  echo "===== AWS Athena List Workgroups:" $PROFILE
  aws athena list-work-groups \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"111" )
  echo "===== AWS Athena Create Workgroup:" $PROFILE
  aws athena create-work-group \
		--name 'Terence-wg1' \
    --description "Terence's test workgroup" \
		--profile $PROFILE \
    --output $OUTPUT
  ;;


"112" )
  echo "===== AWS Athena Update Workgroup:" $PROFILE
  aws athena update-work-group \
		--work-group 'Terence-wg1' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"113" )
  echo "===== AWS Athena Delete Workgroup:" $PROFILE
  aws athena delete-work-group \
		--work-group 'Terence-wg1' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"120" )
  echo "===== AWS Athena List Named [Saved] Queries:" $PROFILE
  aws athena list-named-queries \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"121" )
	echo "===== AWS Athena Create Named [Saved] Query:" $PROFILE
  aws athena create-named-query \
		--name "Terence NQ1" \
		--database 'chicago' \
		--query-string "select * from chicago" \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"122" )
  echo "===== AWS Athena Get Named Queries:" $PROFILE
  aws athena get-named-query \
		--named-query-id 'Terence NQ1' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"123" )
  echo "===== AWS Athena Delete Named [Saved] Queries:" $PROFILE
  aws athena delete-named-query \
		--named-query-id 'xxx' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"150" )
  echo "===== AWS Athena Tag Resource:" $PROFILE
	aws athena tag-resource \
		--resource-arn "" \
		--tags "tagme" \
		--profile $PROFILE \
    --output $OUTPUT 
  ;;


"151" )
  echo "===== AWS Athena UnTag Resource:" $PROFILE
	aws athena untag-resource \
		--resource-arn "" \
		--tags "tagme" \
		--profile $PROFILE \
    --output $OUTPUT 
  ;;


# Attempt to cater for ESC
"\x1B" )
  echo ESC1
  exit 0
  ;;


# Attempt to cater for ESC
"^[" )
  echo ESC2
  exit 0
  ;;

# ------------------------------------------------
#  GIT
# ------------------------------------------------
* )
  # Default option.
  # Empty input (hitting RETURN) fits here, too.
  echo
  echo "Not a recognized option."
  ;;
esac




