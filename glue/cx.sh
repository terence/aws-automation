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

GLUE_DATABASE="glue-db1"
GLUE_CRAWLER_CODE="glue-crawler1"
GLUE_CRAWLER_NAME="terence-crawler1"

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS Lambda
echo ----------------------------------------------
echo 100 : AWS Glue Get Databases
echo 101 : AWS Glue Create Databases
echo 102 : AWS Glue Update Databases
echo 103 : AWS Glue Delete Databases
echo ----------------------------------------------
echo 110 : AWS Glue Get Tables
echo 111 : AWS Glue Get Table
echo 112 : AWS Glue Update Tables
echo 113 : AWS Glue Delete Tables
echo ----------------------------------------------
echo 120 : AWS Glue Get Connections
echo ----------------------------------------------
echo 130 : AWS Glue Get Crawlers
echo 131 : AWS Glue Create Crawlers
echo 132 : AWS Glue Update Crawler
echo 133 : AWS Glue Update Crawler Schedule
echo 134 : AWS Glue Start Crawlers
echo 135 : AWS Glue Start Crawlers Schedule
echo 136 : AWS Glue Stop Crawlers
echo 137 : AWS Glue Stop Crawlers Schedule
echo 138 : AWS Glue Delete Crawlers
echo ----------------------------------------------
echo 140 : AWS Glue Get Classifers
echo ----------------------------------------------
echo 150 : AWS Glue Get Workflows
echo ----------------------------------------------
echo 160 : AWS Glue Get Jobs
echo ----------------------------------------------
echo 170 : AWS Glue Get ML Transforms
echo ----------------------------------------------
echo 180 : AWS Glue Get Triggers
echo ----------------------------------------------
echo 190 : AWS Glue Get Dev Endpoints
echo ----------------------------------------------
echo 200 : AWS Glue Get Notebooks
echo ----------------------------------------------
echo 210 : AWS Glue Get Security Configuration
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
  echo "===== AWS Glue Get Databases:" $PROFILE
  aws glue get-databases \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"101" )
  echo "===== AWS Glue Create Database:" $PROFILE
  aws glue create-database \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"102" )
  echo "===== AWS Glue Update Database:" $PROFILE
  aws glue update-database \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"103" )
  echo "===== AWS Glue Delete Database:" $PROFILE
  aws glue delete-database \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"110" )
  echo "===== AWS Glue Get Tables:" $PROFILE
  aws glue get-tables \
    --database-name 'workshop' \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"120" )
  echo "===== AWS Glue Get Connections:" $PROFILE
  aws glue get-connections \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"130" )
  echo "===== AWS Glue Get Crawlers:" $PROFILE
  aws glue get-crawlers \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"131" )
  echo "===== AWS Glue Create Crawlers:" $PROFILE
	aws glue create-crawler \
    --name $GLUE_CRAWLER_NAME \
    --role 'extensive-semantic-layer-role' \i
#		--targets '{"S3Targets": [{"Path": "s3://ipa-bia-enriched-shared-dev/chicago/" }]}' \
		--profile $PROFILE \
    --output $OUTPUT
  ;;

"132" )
  echo "===== AWS Glue Update Crawler:" $PROFILE
  aws glue update-crawler \
    --name $GLUE_CRAWLER_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"133" )
  echo "===== AWS Glue Update Crawler Schedule:" $PROFILE
  aws glue update-crawler-schedule \
    --crawler-name $GLUE_CRAWLER_NAME \
#		--schedule '' \
		--profile $PROFILE \
    --output $OUTPUT
  ;;



"134" )
  echo "===== AWS Glue Start Crawler:" $PROFILE
  aws glue start-crawler \
    --name $GLUE_CRAWLER_NAME \
		--profile $PROFILE \
    --output $OUTPUT
  ;;

"135" )
  echo "===== AWS Glue Start Crawler Schedule:" $PROFILE
  aws glue start-crawler \
    --crawler-name $GLUE_CRAWLER_NAME \
		--profile $PROFILE \
    --output $OUTPUT
  ;;

"136" )
  echo "===== AWS Glue Stop Crawler:" $PROFILE
  aws glue stop-crawler \
    --name $GLUE_CRAWLER_NAME \
		--profile $PROFILE \
    --output $OUTPUT
  ;;

"137" )
  echo "===== AWS Glue Stop Crawler Schedule:" $PROFILE
  aws glue stop-crawler \
    --crawler-name $GLUE_CRAWLER_NAME \
		--profile $PROFILE \
    --output $OUTPUT
  ;;

"138" )
  echo "===== AWS Glue Delete Crawler:" $PROFILE
  aws glue delete-crawler \
    --name $GLUE_CRAWLER_NAME \
		--profile $PROFILE \
    --output $OUTPUT
  ;;

"140" )
  echo "===== AWS Glue Get Classifiers:" $PROFILE
  aws glue get-classifiers \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"150" )
  echo "===== AWS Glue List Workflows:" $PROFILE
	aws glue list-workflows \
		--profile $PROFILE \
    --output $OUTPUT 
  ;;

#    --invocation-type Event \
#		-- payload '{"key1":"value1"}' \

"160" )
  echo "===== AWS Glue List Jobs:" $PROFILE
  aws lambda delete-function \
    --function-name $FUNCTION_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"114" )
  echo "===== AWS Lambda Get Function Configuration:" $PROFILE
  aws lambda get-function-configuration \
    --function-name $FUNCTION_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"115" )
  echo "===== AWS Lambda Update Function Configuration:" $PROFILE
  aws lambda update-function-configuration \
    --function-name $FUNCTION_NAME \
    --memory-size 256
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




