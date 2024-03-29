The following is a guide for creating an Amazon Machine Image (AMI) using Packer and shell script. The Packer file will create an AMI file which can be shared across Dev and Demo accounts. Once the AMI is created, an EC2 instance can be created using Terraform. The public address of the instance can be obtained and the Webapp that was created can be run

The Webapp is used for API testing and is created using Node.js and MYSQL2. The API requests can be tested using POSTMAN. The prerequisites for this project include Visual Studio Code, POSTMAN, MySQL database, Node.js, AWS, and Terraform.

The .sh file includes dependencies that need to be installed, such as Node.js and Mariadb. The commands in the .sh file include unzipping the Webapp.zip file, installing nginx, and enabling and starting webapp and nginx services.

The endpoints available for operations include GET, POST, PUT, PATCH, and DELETE requests for users and products. The HTTP messages that can be received include "200 OK," "201 Created," "204 No Content," "400 Bad Request," "401 Unauthenticated," "403 Forbidden," and "500 Internal Server Error."

To test the API calls, appropriate files need to be created in an IDE and the code can be written. POSTMAN can be used to test the APIs, and the database can be checked after each API call to see the status. After testing, a pull request with a detailed description of changes can be created.

Amazon RDS creates the database schema and APIs can be tested through it. The Image details are stored in the RDS and meta data is stored in S3.

## Prerequisites

1.Visual studio code (IDE)
2.POSTMAN
3.Database - MySQL
4.Node.js
5.AWS
6.Terraform
7.Packer

## Dependencies to be installed .sh file

install node
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo yum install -y nodejs

#unzip the file
unzip webapp.zip -d webapp
cd /home/ec2-user/webapp
npm i

sudo cp ./webapp.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable webapp.service


<h4>Important Commands to run the server and test</h4>


## Endpoints
The following endpoints are available for operations:

GET - http://localhost:3000/v1/user/{id}

POST - http://localhost:3000/v1/user

PUT - http://localhost:3000/v1/user/{id}

GET - http://localhost:3000/v1/user/{id}

GET - http://localhost:3000/v1/product/{id}

POST - http://localhost:3000/v1/product

PUT - http://localhost:3000/v1/product/{id}

GET - http://localhost:3000/v1/product/{id}

PATCH - http://localhost:3000/v1/product/{id}

DELETE - http://localhost:3000/v1/product/{id}

POST - http://localhost:3000/v1/{product_id}/image

GET - http://localhost:3000/v1/{product_id}/image

GET - http://localhost:3000/v1/{product_id}/image/{image_id}

DELETE - http://localhost:3000/v1/{product_id}/image/{image_id}





## Responds with following HTTP messages

"200 OK - The request was successful."

"201 Created - A new resource was created as a result of the request, often sent in response to a POST or some PUT requests."

"204 No Content - The request was successful, but there's no need for the client to navigate away from its current page."

"400 Bad Request - The server could not process the request due to an invalid syntax."

"401 Unauthenticated - The client must provide authentication to receive the requested response."

"403 Forbidden - The client does not have access to the requested resource."

"500 Internal Server Error - The server encountered an issue it couldn't handle."


Instructions:

Step 1: Clone the repository or download and unzip the source repository.

Step 2: Make changes in readme and create a PR.

Step 2: Once the code is merged in the org repo the packer file creates an AMI in the aws console. Check for the ami.

Step 3: Check if the packer has zipped your webapp.

Step 4: Run the aws infrastructure by doing Terraform init, terraform plan, terraform apply. The resources and EC2 instance is created.

Step 5: Copy the IP4 address of the AMI created.

Step 6: Hit the apis.

Test the api

http://localhost:3000/v1/user, where you should see: "200 OK".

http://localhost:3000/v1/user/{id} where you should see: "201 Created".

http://localhost:3000/v1/user/self/ where you should see: "204 No Content".

http://localhost:3000/v1/user/self where you should use: "204 No Content".

http://localhost:3000/v1/product, where you should see: "200 OK".

http://localhost:3000/v1/product/{id} where you should see: "201 Created".

http://localhost:3000/v1/product/self/ where you should see: "204 No Content".

http://localhost:3000/v1/{product_id}/self where you should see "200 OK".

http://localhost:3000/v1/{product_id}/self where you should see "201 File Uploaded".

http://localhost:3000/v1/{product_id}/image/{image_id} where you should see "204 No Content"



Please create a pull request with a detailed description of changes.
