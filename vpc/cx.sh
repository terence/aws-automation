# AWS Scripts Command-line Assistant
#================================================================
clear
source ./vars.sh

PWD=pwd

# DEFAULTS
PROFILE="ipadev"
REGION="ap-southeast-2"
OUTPUT="json"

echo =============================================================
echo Hi $USER@$HOSTNAME. You are in $PWD directory.
echo -------------------------------------------------------------
echo 001 : AWS Configure
echo 002 : AWS S3 List
echo 003 : AWS STS Assume Role
echo ----------------------------------------------
echo 100 : AWS EC2 describe-vpcs
echo 101 : AWS EC2 create-vpc
echo 102 : AWS EC2 delete-vpc
echo ----------------------------------------------
echo 120 : AWS EC2 describe-subnets
echo 121 : AWS EC2 create-subnet
echo 122 : AWS EC2 delete-subnet
echo ----------------------------------------------
echo 140 : AWS EC2 describe-vpn-gateways
echo ----------------------------------------------
echo 160 : AWS EC2 describe-nat-gateways
echo ----------------------------------------------
echo 180 : AWS EC2 describe-transit-gateways
echo ----------------------------------------------
echo 200 : AWS EC2 describe-internet-gateways
echo ----------------------------------------------
echo 220 : AWS EC2 describe-network-interfaces
echo ----------------------------------------------
echo 240 : AWS EC2 describe-route-tables
echo 241 : AWS EC2 create-route-table
echo 242 : AWS EC2 delete-route-table
echo 243 : AWS EC2 create-route
echo 244 : AWS EC2 delete-route
echo ----------------------------------------------
echo 260 : AWS EC2 describe-network-acls
echo ----------------------------------------------
echo 280 : AWS EC2 describe-security-groups
echo ----------------------------------------------
echo 300 : AWS EC2 describe-vpc-endpoints
echo 301 : AWS EC2 create-vpc-endpoint
echo 302 : AWS EC2 modify-vpc-endpoint
echo 303 : AWS EC2 delete-vpc-endpoints
echo ----------------------------------------------
echo 320 : AWS EC2 describe-vpc-peering-connections
echo ----------------------------------------------
echo 400 : AWS EC2 describe-addresses
echo 401 : AWS EC2 allocate-address
echo 402 : AWS EC2 associate-address
echo 403 : AWS EC2 disassociate-address
echo 404 : AWS EC2 release-address
echo ----------------------------------------------
echo 500 : AWS EC2 describe-flow-logs
echo 501 : AWS EC2 create-flow-logs
echo 502 : AWS EC2 delete-flow-logs
echo ----------------------------------------------
echo 800 : AWS CloudFormation create-stack Create Sandpit VPC
echo 801 : AWS CloudFormation deploy Create Sandpit VPC
echo 802 : AWS CloudFormation delete-stack Delete Sandpit VPC
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
  echo "===== AWS VPC describe-vpcs:" $PROFILE
  aws ec2 describe-vpcs \
    --profile $PROFILE \
    --output table
  ;;

"101" )
  echo "===== AWS VPC create-vpc:" $PROFILE
  aws ec2 create-vpc \
		--ipv6-cidr-block-network-border-group ap-southeast-2 \
		--cidr-block "10.0.0.0/20" \
#		--dry-run \
#    --profile $PROFILE \
#    --output table
  ;;


"102" )
  echo "===== AWS VPC delete-vpc:" $PROFILE
  aws ec2 delete-vpc \
		--vpc-id 'vpc-03c7b24ee73aaa89a' \
		--dry-run \
    --profile $PROFILE 
#    --output table
  ;;


"120" )
  echo "===== AWS VPC describe-subnets:" $PROFILE
  aws ec2 describe-subnets \
    --profile $PROFILE \
    --output table
  ;;


"121" )
  echo "===== AWS VPC create-subnet:" $PROFILE
  aws ec2 create-subnet \
		--vpc-id 'vpc-03c7b24ee73aaa89a' \
    --cidr-block '10.0.0.0/21' \
		--dry-run \
    --profile $PROFILE 
#    --output table
  ;;


"122" )
  echo "===== AWS VPC delete-subnet:" $PROFILE
  aws ec2 delete-subnet \
		--subnet-id 'xxx' \
		--dry-run \
    --profile $PROFILE 
#    --output table
  ;;




"140" )
  echo "===== AWS VPC describe-vpn-gateways:" $PROFILE
  aws ec2 describe-vpn-gateways \
    --profile $PROFILE \
    --output table
  ;;


"141" )
  echo "===== AWS VPC create-vpn-gateway:" $PROFILE
  aws ec2 create-vpn-gateway \
    --type 'ipsec.1' \
	  --dry-run \
		--profile $PROFILE \
    --output table
  ;;


"160" )
  echo "===== AWS VPC describe-nat-gateways:" $PROFILE
  aws ec2 describe-nat-gateways \
    --profile $PROFILE \
    --output table
  ;;


"180" )
  echo "===== AWS VPC describe-transit-gateways:" $PROFILE
  aws ec2 describe-transit-gateways \
    --profile $PROFILE \
    --output table
  ;;



"200" )
  echo "===== AWS VPC describe-internet-gateways:" $PROFILE
  aws ec2 describe-internet-gateways \
    --profile $PROFILE \
    --output table
  ;;

"220" )
  echo "===== AWS VPC describe-network-interfaces:" $PROFILE
  aws ec2 describe-internet-gateways \
    --profile $PROFILE \
    --output table
  ;;

"240" )
  echo "===== AWS VPC describe-route-tables:" $PROFILE
  aws ec2 describe-route-tables \
    --profile $PROFILE \
    --output table
  ;;


"241" )
  echo "===== AWS VPC create-route-table:" $PROFILE
  aws ec2 create-route-table \
    --vpc-id 'xxx' \
		--dry-run \
    --profile $PROFILE \
    --output table
  ;;


"242" )
  echo "===== AWS VPC delete-route-table:" $PROFILE
  aws ec2 delete-route-table \
    --route-table-id 'rtb-0be454e7b02bdaf44' \
		--dry-run \
    --profile $PROFILE \
    --output table
  ;;



"243" )
  echo "===== AWS VPC create-route:" $PROFILE
  aws ec2 create-route \
    --route-table-id 'xxx' \
		--dry-run \
    --profile $PROFILE \
    --output table
  ;;


"244" )
  echo "===== AWS VPC delete-route:" $PROFILE
  aws ec2 delete-route \
    --route-table-id 'xxx' \
		--dry-run \
    --profile $PROFILE \
    --output table
  ;;


"260" )
  echo "===== AWS VPC describe-network-acls:" $PROFILE
  aws ec2 describe-network-acls \
    --profile $PROFILE \
    --output table
  ;;


"280" )
  echo "===== AWS VPC describe-security-groups:" $PROFILE
  aws ec2 describe-security-groups \
    --profile $PROFILE \
    --output table
  ;;

"300" )
  echo "===== AWS VPC describe-vpc-endpoints:" $PROFILE
  aws ec2 describe-vpc-endpoints \
    --profile $PROFILE \
    --output table
  ;;

"301" )
  echo "===== AWS VPC create-vpc-endpoint:" $PROFILE
  aws ec2 create-vpc-endpoint \
    --vpc-id 'xxx' \
		--service com.amazonaws.ap-southeast-2.s3 \
		--dryrun \
		--profile $PROFILE \
    --output table
  ;;

"302" )
  echo "===== AWS VPC modify-vpc-endpoint:" $PROFILE
  aws ec2 modify-vpc-endpoint \
    --vpc-endpoint-id vpce-aa22bb33 \
		--dryrun \
    --profile $PROFILE \
    --output table
  ;;


"303" )
  echo "===== AWS VPC delete-vpc-endpoints:" $PROFILE
  aws ec2 delete-vpc-endpoints \
    --vpc-endpoint-idsi vpce-aa22bb33 vpce-1a2b3c4d \
		--dryrun \
    --profile $PROFILE \
    --output table
  ;;


"320" )
  echo "===== AWS VPC describe-vpc-peering-connections:" $PROFILE
  aws ec2 describe-vpc-peering-connections \
    --profile $PROFILE \
    --output table
  ;;


"400" )
  echo "===== AWS VPC describe-addresses:" $PROFILE
  aws ec2 describe-addresses \
    --profile $PROFILE \
    --output table
  ;;


"500" )
  echo "===== AWS VPC describe-flow-logs:" $PROFILE
  aws ec2 describe-flow-logs \
    --profile $PROFILE \
    --output table
  ;;


"501" )
  echo "===== AWS VPC create-flow-logs:" $PROFILE
  aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-00112233344556677 \
    --traffic-type ALL \
    --log-destination-type s3 \
    --log-destination arn:aws:s3:::flow-log-bucket/my-custom-flow-logs/ \
    --log-format '${version} ${vpc-id} ${subnet-id} ${instance-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${tcp-flags} ${type} ${pkt-srcaddr} ${pkt-dstaddr}' \
	  --profile $PROFILE \
    --output table
	;;


"502" )
  echo "===== AWS VPC delete-flow-logs:" $PROFILE
  aws ec2 delete-flow-logs \
	  --flow-log-id fl-xxxx \
    --profile $PROFILE \
    --output table
  ;;


"800" )
  echo "===== AWS CF create-stack Create Sandpit VPC:" $PROFILE
  STACK_NAME="sandpit-vpc-stack1"
  aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --template-body file://stacks/vpc-sandpit-cf1.yaml \
    --role-arn $STACK_ROLE \
  ;;


"801" )
  echo "===== AWS CF create-stack Deploy Sandpit VPC:" $PROFILE
  STACK_NAME="sandpit-vpc-stack1"
  aws cloudformation deploy \
    --stack-name $STACK_NAME \
    --template-file ./stacks/vpc-sandput-cf1.yaml \
    --role-arn $STACK_ROLE \
  ;;


"802" )
  echo "===== AWS CF delete-stack Delete Sandpit VPC:" $PROFILE
  STACK_NAME="sandpit-vpc-stack1"
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



