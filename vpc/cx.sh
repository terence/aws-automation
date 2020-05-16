# AWS Scripts Command-line Assistant
#================================================================
clear
#source ./vars.sh
PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"
EMR_CLUSTER_ID="xxx"



echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS STS Assume Role
echo ----------------------------------------------
echo ----------------------------------------------
echo 500 : AWS EC2 describe-vpcs
echo 501 : AWS EC2 describe-subnets
echo 502 : AWS EC2 describe-vpn-gateways
echo 503 : AWS EC2 describe-nat-gateways
echo 504 : AWS EC2 describe-transit-gateways
echo 505 : AWS EC2 describe-route-tables
echo 506 : AWS EC2 xxx
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



"500" )
  echo "===== AWS VPC describe-vpcs:" $PROFILE
  aws ec2 describe-vpcs \
    --profile $PROFILE \
    --output table
  ;;


"501" )
  echo "===== AWS VPC describe-subnets:" $PROFILE
  aws ec2 describe-subnets \
    --profile $PROFILE \
    --output table
  ;;


"502" )
  echo "===== AWS VPC describe-vpn-gateways:" $PROFILE
  aws ec2 describe-vpn-gateways \
    --profile $PROFILE \
    --output table
  ;;


"503" )
  echo "===== AWS VPC describe-nat-gateways:" $PROFILE
  aws ec2 describe-nat-gateways \
    --profile $PROFILE \
    --output table
  ;;


"504" )
  echo "===== AWS VPC describe-transit-gateways:" $PROFILE
  aws ec2 describe-transit-gateways \
    --profile $PROFILE \
    --output table
  ;;

"505" )
  echo "===== AWS VPC describe-route-tables:" $PROFILE
  aws ec2 describe-route-tables \
    --profile $PROFILE \
    --output table
  ;;

"506" )
  echo "===== AWS VPC describe-transit-gateways:" $PROFILE
  aws ec2 describe-transit-gateways \
    --profile $PROFILE \
    --output table
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



