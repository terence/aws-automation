# AWS Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
DRYRUN_FLAG=true


echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS STS Assume Role
echo ----------------------------------------------
echo 100 : AWS configservice list-discovered-resources
echo 200 : AWS configservice describe-config-rules
echo 201 : AWS configservice put-config-rule
echo ----------------------------------------------
echo 300 : AWS configservice describe-conformance-packs
echo ----------------------------------------------
echo 500 : AWS configservice describe-configuration-recorders
echo 501 : AWS configservice start-configuration-recorder
echo 502 : AWS configservice stop-configuration-recorder
echo 503 : AWS configservice describe-delivery-channels
echo 504 : AWS configservice put-delivery-channel
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


"003" )
  echo "===== AWS Assume Role:" $PROFILE
  aws sts assume-role \
		--role-arn "$STS_ROLE" \
		--role-session-name AWSCLI-Session
  aws sts get-caller-identity \
		--profile $PROFILE
  ;;
    

"100" )
  echo "===== AWS configservice list-discovered-resources:" $PROFILE
  echo "# of VPCs: "
  aws configservice list-discovered-resources \
    --resource-type AWS::EC2::VPC \
    --profile $PROFILE \
    --output text | wc -l
  echo "# of S3 Buckets: "
  aws configservice list-discovered-resources \
    --resource-type AWS::S3::Bucket \
    --profile $PROFILE \
    --output text | wc -l
  echo "# of Dynamo Tables: "
  aws configservice list-discovered-resources \
    --resource-type AWS::DynamoDB::Table \
    --profile $PROFILE \
    --output text | wc -l
  echo "# of Lambda: "
  aws configservice list-discovered-resources \
    --resource-type AWS::Lambda::Function \
    --profile $PROFILE \
    --output text | wc -l
  echo "# of IAM Users: "
  aws configservice list-discovered-resources \
    --resource-type AWS::IAM::User \
    --profile $PROFILE \
    --output text | wc -l
  echo "# of IAM Groups: "
  aws configservice list-discovered-resources \
    --resource-type AWS::IAM::Group \
    --profile $PROFILE \
    --output text | wc -l
  echo "# of IAM Roles: "
  aws configservice list-discovered-resources \
    --resource-type AWS::IAM::Roole \
    --profile $PROFILE \
    --output text | wc -l
  echo "# of IAM Policies: "
  aws configservice list-discovered-resources \
    --resource-type AWS::IAM::Policy \
    --profile $PROFILE \
    --output text | wc -l
		
	;;


"200" )
  echo "===== AWS configservice describe-config-rules:" $PROFILE
  aws configservice describe-config-rules \
    --output $OUTPUT \
    --profile $PROFILE
  echo "# of Config Rules: "
  aws configservice describe-config-rules \
    --profile $PROFILE \
    --output text | wc -l
	
	
	;;

"201" )
  echo "===== AWS configservice put-config-rule:" $PROFILE
  CONFIG_RULE="testrule1"
  aws configservice put-config-rule \
    --config-rule file://RequiredTagsForEC2Instances.json \
    --profile $PROFILE \
    --output table
  ;;


"202" )
  echo "===== AWS configservice delete-config-rule:" $PROFILE
  CONFIG_RULE="testrule1"
	aws configservice delete-config-rule \
    --config-rule-name $CONFIG_RULE \
		--profile $PROFILE \
    --output table
  ;;


"300" )
  echo "===== AWS configservice describe-conformance-packs:" $PROFILE
  aws configservice describe-conformance-packs \
    --profile $PROFILE \
    --output text
  ;;


"500" )
  echo "===== AWS configservice describe-configuration-recorders" $PROFILE
  aws configservice describe-configuration-recorders \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"501" )
  echo "===== AWS configservice start-configuratiion-recorder:" $PROFILE
  aws configservice start-configuration-recorder \
		--configuration-recorder-name default \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"502" )
  echo "===== AWS configservice stop-configuratiion-recorder:" $PROFILE
  aws configservice stop-configuration-recorder \
		--configuration-recorder-name default \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"503" )
  echo "===== AWS configservice describe-delivery-channels:" $PROFILE
  aws configservice describe-delivery-channels \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"504" )
  echo "===== AWS configservice describe-delivery-channels:" $PROFILE
  aws configservice put-delivery-channel \
		--delivery-channel file://deliveryChannel.json
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



