Developed a web application using Nodejs/Express REST API which performs basic data manipulation on user data in MySQL, includes basic auth and password encryption, performed Continuous Integration using github workflows.

USER REQUIREMENTS:

As a user, I should be able create a new user account by providing user input. The system must then validate and auto-generate some fields and store the data securely.
As a user, I should be able to login to the system using correct credentials.
As a user, I should be able to update certain account information fields.
System should provide endpoint to check if the system is operational and healthy

-----------------------------------------------------------------------------------------------------------------

TECHINCAL REQUIREMENTS:

The goal of this assignment is to learn usage of GitHub workflows and mock real world repository to perform Continuous Integration.
Build 4 REST API services
Write Unit tests for the endpoints and build a workflow to run when new pull request is created.

-----------------------------------------------------------------------------------------------------------------

USED TOOLS:

MySQL

Nodejs

Expressjs

Postman

-----------------------------------------------------------------------------------------------------------------

CREATED FILES:

I've created API modules as follow:

>api-routes
	-userRoutes.js

>config
	-helper.js

>models
	-dbFuncs.js

>services
	-user.js

>app.js
>server.js
>.github/workflows
	-workflow.yml

-----------------------------------------------------------------------------------------------------------------

HOW TO RUN:

Start by cloning this repository to your localhost:

git clone git@github.com:AnkitLallOrganization/webapp.git

Open the folder in VScode -> Go to app.js -> Open Terminal -> run on terminal command prompt ->cd /webapp && npm install && npm install zest

To run the tests: npm run test

After installing all dependencies run -> npm start run.


-----------------------------------------------------------------------------------------------------------------


If you want to contact with me you can reach me at lall.an@northeastern.edu

Thanks

Ankit Lall NU ID : 002799095

