#!/bin/bash

sudo yum update -y
sudo yum upgrade -y

sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo yum install -y nodejs

unzip webapp.zip -d webapp
cd /home/ec2-user/webapp
npm i

sudo cp ./packer/webapp.service /etc/systemd/system/

sudo yum install amazon-cloudwatch-agent -y

# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install

echo $access_key_id
echo $access_key
echo $ami

aws configure set aws_access_key_id $access_key_id
aws configure set aws_secret_access_key $access_key
aws configure set default.region "us-east-1"
aws ec2 create-launch-template-version --launch-template-id "lt-0d128dcf62f045e91" --launch-template-data '{"ImageId":"$ami"}'
# aws ec2 create-launch-template-version
aws ec2 start-instance-refresh --auto-scaling-group-name "asg_launch_config"