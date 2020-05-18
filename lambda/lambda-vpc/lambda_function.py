import json
import boto3
from foundation import vpc


def lambda_handler(event, context):
    # TODO implement

    ec2 = boto3.resource('ec2')
    #vpc = ec2.vpc('id')
    #ec2client = boto3.client('ec2')
    #regionresponse = ec2client.describe_regions()
    #for region in regionresponse["Regions"] 
    #    regionname = region["RegionName"]     

    vpc = ec2.create_vpc(CidrBlock='11.0.0.0/20')
    vpc.wait_until_available()
    vpc.create_tags(Tags=[{"Key": "Name", "Value": "my_vpc"}])



    ec2client = boto3.client('ec2', region_name='ap-southeast-2')
    instanceresponse = ec2client.describe_instances()
#    print (json.dumps(instanceresponse))
    for reservation in instanceresponse["Reservations"]:
        for instance in reservation["Instances"]:
            print(instance["InstanceId"]) 

    vpcresponse = ec2client.describe_vpcs() 
#    print (json.dumps(vpcresponse))
    for vpc in vpcresponse["Vpcs"]:
        print (vpc["VpcId"])

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda from MacOS2 updates!')
    }
