# AWS Lambda Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
FUNCTION_CODE="lambda-vpc"
FUNCTION_NAME="terence-vpc1"

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS Lambda
echo ----------------------------------------------
echo 100 : AWS Lambda Account Settings
echo 101 : AWS Lambda List Functions
echo 102 : AWS Lambda List Layers
echo ----------------------------------------------
echo 102 : AWS IAM Roles
echo ----------------------------------------------
echo 210 : AWS Lambda lambda-vpc Create Function 
echo 211 : AWS Lambda lambda-vpc Update Function Code
echo 212 : AWS Lambda lambda-vpc Invoke Function
echo 213 : AWS Lambda lambda-vpc Delete Function
echo 214 : AWS Lambda lambda-vpc Get Function Configuration
echo 215 : AWS Lambda lambda-vpc Update Function Configuration
echo ----------------------------------------------
echo 220 : AWS Lambda lambda-iam Create Function 
echo 221 : AWS Lambda lambda-iam Update Function Code
echo 222 : AWS Lambda lambda-iam Invoke Function
echo 223 : AWS Lambda lambda-iam Delete Function
echo 224 : AWS Lambda lambda-iam Get Function Configuration
echo 225 : AWS Lambda lambda-iam Update Function Configuration
echo ----------------------------------------------
echo 500 : AWS STEPFUNCTIONS describe-actiivity
echo 501 : AWS STEPFUNCTIONS xxx
echo 502 : AWS STEPFUNCTIONS xxx
echo ----------------------------------------------
echo 900 : V-Env Create
echo 901 : V-Env Activate
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
  echo "===== AWS Lambda Get Account Settings:" $PROFILE
  aws lambda get-account-settings \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"101" )
  echo "===== AWS Lambda List Functions:" $PROFILE
  aws lambda list-functions \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"102" )
  echo "===== AWS Lambda List Layers:" $PROFILE
  aws lambda list-layers \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"210" )
  echo "===== AWS Lambda Create Function:" $PROFILE
  FUNCTION_CODE="lambda-vpc"
  FUNCTION_NAME="terence-vpc1"
  cd $FUNCTION_CODE
  rm $FUNCTION_CODE.zip
  zip -r $FUNCTION_CODE.zip .
  cd ..
  aws lambda create-function \
    --function-name $FUNCTION_NAME \
    --runtime python3.8 \
    --zip-file fileb://$FUNCTION_CODE/$FUNCTION_CODE.zip \
    --handler lambda_function.lambda_handler \
    --role arn:aws:iam::832435373672:role/service-role/lambda-helloworld1-role-rpwjd1ud \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"211" )
  echo "===== AWS Lambda Update Function Code:" $PROFILE
  FUNCTION_CODE="lambda-vpc"
  FUNCTION_NAME="terence-vpc1"
  cd $FUNCTION_CODE
  rm $FUNCTION_CODE.zip
  zip -r $FUNCTION_CODE.zip .
  cd ..
  aws lambda update-function-code \
    --function-name $FUNCTION_NAME \
    --zip-file fileb://$FUNCTION_CODE/$FUNCTION_CODE.zip \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"212" )
  echo "===== AWS Lambda Invoke Function:" $PROFILE
  FUNCTION_CODE="lambda-vpc"
  FUNCTION_NAME="terence-vpc1"
	aws lambda invoke \
    --function-name $FUNCTION_NAME \
		--profile $PROFILE \
    --output $OUTPUT \
		response.json
  ;;

#    --invocation-type Event \
#		-- payload '{"key1":"value1"}' \

"213" )
  echo "===== AWS Lambda Delete Function:" $PROFILE
  FUNCTION_NAME="terence-vpc1"
  aws lambda delete-function \
    --function-name $FUNCTION_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"214" )
  echo "===== AWS Lambda Get Function Configuration:" $PROFILE
  FUNCTION_NAME="terence-vpc1"
  aws lambda get-function-configuration \
    --function-name $FUNCTION_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"215" )
  echo "===== AWS Lambda Update Function Configuration:" $PROFILE
  FUNCTION_NAME="terence-vpc1"
  aws lambda update-function-configuration \
    --function-name $FUNCTION_NAME \
    --memory-size 256
		--profile $PROFILE \
    --output $OUTPUT
  ;;


"220" )
  echo "===== AWS Lambda Create Function:" $PROFILE
  FUNCTION_CODE="lambda-iam"
  FUNCTION_NAME="terence-iam1"
  cd $FUNCTION_CODE
  rm $FUNCTION_CODE.zip
  zip -r $FUNCTION_CODE.zip .
  cd ..
  aws lambda create-function \
    --function-name $FUNCTION_NAME \
    --runtime python3.8 \
    --zip-file fileb://$FUNCTION_CODE/$FUNCTION_CODE.zip \
    --handler lambda_function.lambda_handler \
    --role arn:aws:iam::832435373672:role/service-role/lambda-helloworld1-role-rpwjd1ud \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"221" )
  echo "===== AWS Lambda Update Function Code:" $PROFILE
  FUNCTION_CODE="lambda-iam"
  FUNCTION_NAME="terence-iam1"
  cd $FUNCTION_CODE
  rm $FUNCTION_CODE.zip
  zip -r $FUNCTION_CODE.zip .
  cd ..
  aws lambda update-function-code \
    --function-name $FUNCTION_NAME \
    --zip-file fileb://$FUNCTION_CODE/$FUNCTION_CODE.zip \
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




