# AWS Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
STACK_NAME="BIA-IPA-stack1"


echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS STS Assume Role
echo ----------------------------------------------
echo 010 : AWS IAM List Users
echo 011 : AWS IAM List Roles
echo 012 : AWS IAM List Groups
echo 013 : AWS IAM List Policies
echo 014 : AWS IAM List access-keys
echo ----------------------------------------------
echo 020 : AWS ORGANIZATIONS List Accounts
echo 021 : AWS ORGANISATIONS List Roots
echo ----------------------------------------------
echo 200 : AWS CloudFormation create-stack Add Users 
echo 201 : AWS CloudFormation delete-stack Delete Users 
echo ----------------------------------------------
echo 211 : AWS CloudFormation create-stack Add Groups 
echo 211 : AWS CloudFormation delete-stack Delete Groups 
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
  # aws sts assume-role --role-arn "arn:aws:iam::xxxxxxxxxxxx:role/AWSAdmin" --role-session-name AWSCLI-Session
  # aws sts get-caller-identity --profile ipadev 
  ;;

    
"010" )
  echo "===== AWS IAM List Users:" $PROFILE
  aws iam list-users \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"011" )
  echo "===== AWS IAM List Roles:" $PROFILE
  aws iam list-roles \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"012" )
  echo "===== AWS IAM List Groups:" $PROFILE
  aws iam list-groups \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"013" )
  echo "===== AWS IAM List Policies:" $PROFILE
  aws iam list-policies \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"014" )
  echo "===== AWS IAM List Access Keys:" $PROFILE
  aws iam list-access-keys \
    --user-name terence.chia
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"020" )
  echo "===== AWS ORGANIZATIONS  List Accounts:" $PROFILE
  aws organizations list-accounts \
    --profile $PROFILE \
    --output $OUTPUT
  ;;


"021" )
  echo "===== AWS ORGANIZATIONS  List Roots:" $PROFILE
  aws organizations list-roots \
    --profile $PROFILE \
    --output $OUTPUT
  ;;

"200" )
  echo "===== AWS CF create-stack Add Users:" $PROFILE
  STACK_NAME="terence-iam-stack1"
  aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --template-body file://stacks/iam-users-cf1.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
#    --role-arn arn:aws:iam::832435373672:role/Git2S3 
#    --role-arn $STACK_ROLE \
  ;;


"201" )
  echo "===== AWS CF delete-stack Add Users:" $PROFILE
  STACK_NAME="terence-iam-stack1"
  aws cloudformation delete-stack \
    --stack-name $STACK_NAME \
    --profile $PROFILE \
    --output $OUTPUT
  ;;




"210" )
  echo "===== AWS CF create-stack Add Groups:" $PROFILE
  STACK_NAME="terence-iam-stack2"
  aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --template-body file://stacks/iam-groups-cf1.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --role-arn arn:aws:iam::832435373672:role/Git2S3 
#    --role-arn $STACK_ROLE \
  ;;


"211" )
  echo "===== AWS CF delete-stack Delete Groups:" $PROFILE
  STACK_NAME="terence-iam-stack2"
  aws cloudformation delete-stack \
    --stack-name $STACK_NAME \
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



