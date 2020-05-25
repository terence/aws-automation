# AWS Scripts Command-line Assistant
#================================================================
clear
source ./vars.sh

PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
STACK_NAME="terence-stack1"

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS STS Assume Role
echo ----------------------------------------------
echo 100 : AWS CloudFormation list-stacks
echo 101 : AWS CloudFormation describe-stacks
echo 102 : AWS CloudFormation describe-stack-resources
echo 120 : AWS CloudFormation describe-type
echo 121 : AWS CloudFormation describe-account-limits
echo ----------------------------------------------
echo 200 : AWS CloudFormation create-stack
echo 201 : AWS CloudFormation update-stack
echo 202 : AWS CloudFormation delete-stack
echo 210 : AWS CloudFormation deploy
echo ----------------------------------------------
echo 300 : AWS CloudFormation list-stack-sets
echo 301 : AWS CloudFormation create-stack-set
echo 302 : AWS CloudFormation update-stack-set
echo 303 : AWS CloudFormation delete-stack-set
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
  echo "===== AWS CF list-stacks:" $PROFILE
  aws cloudformation list-stacks \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"101" )
  echo "===== AWS CF describe-stacks:" $PROFILE
  aws cloudformation describe-stacks \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"102" )
  echo "===== AWS CF describe-stack-resources:" $PROFILE
  STACK_NAME="terence-stack1"
  aws cloudformation describe-stack-resources \
    --stack-name $STACK_NAME \
		--profile $PROFILE \
    --output $OUTPUT
  ;;


"120" )
  echo "===== AWS CF describe-type:" $PROFILE
  aws cloudformation describe-type \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"121" )
  echo "===== AWS CF describe-account-limits:" $PROFILE
  aws cloudformation describe-account-limits \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"200" )
  echo "===== AWS CF create-stack:" $PROFILE
  STACK_NAME="terence-stack1"
	aws cloudformation create-stack \
		--stack-name $STACK_NAME \
		--template-body file://stacks/helloworld-cf1.yaml \
    --role-arn arn:aws:iam::832435373672:role/Git2S3 
#    --role-arn $STACK_ROLE \
  ;;


"202" )
  echo "===== AWS CF delete-stack:" $PROFILE
  STACK_NAME="terence-stack1"
	aws cloudformation delete-stack \
		--stack-name $STACK_NAME \
#		--profile $PROFILE \
#    --output $OUTPUT
  ;;


"210" )
  echo "===== AWS CF deploy:" $PROFILE
  STACK_NAME="terence-stack1"
	aws cloudformation deploy \
		--stack-name $STACK_NAME \
		--template-file ./stacks/helloworld-cf1.yaml \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"300" )
  echo "===== AWS CF list-stack-sets:" $PROFILE
  aws cloudformation list-stack-sets \
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



