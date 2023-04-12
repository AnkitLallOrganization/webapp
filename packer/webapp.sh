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

#aws create-launch-template-version --launch-template-data '{"ImageId":$ami}'
aws create-launch-template-version
aws start-instance-refresh --auto-scaling-group-name "asg_launch_config"