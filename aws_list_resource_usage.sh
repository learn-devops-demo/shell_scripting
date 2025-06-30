#!/bin/bash

###################################################
# Author: Keerthana
# Date: 06-04-2025
# Version: v1
# Desc: This script will report aws resource usage
###################################################

#To run in debug mode and exit incase of any error
#set -xeo pipefail

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

#AWS S3
echo "List of s3 buckets:"
aws s3 ls

#AWS EC2
echo "List of EC2 instances:" 
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' 

#AWS Lambda
echo "List of Lambda functions:" 
aws lambda list-functions | jq '.Functions[]' 

#AWS IAM Users
echo "List of IAM Users:"
aws iam list-users | jq '.Users[].UserName'  

