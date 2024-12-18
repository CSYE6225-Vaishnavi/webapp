README.md
Prerequisites: The web application has been built using nodeJS, PostgresSql as the database. The APIs implemented are GET, POST and PUT as per the given requirements. Packer to be installed and added to the environment variables path The API's can be tested with the Postman with the correct routes as configured.

Requirements and Description: The payload will be sent in JSON format in the body of the request. No UI has been implemented in this application. The API calls will return proper HTTP status codes A packer template is written in pkr.hcl format with the required provisioner files like the node.sh, postgres.sh to validate and build the packer with the configured local source directory and remote destination directory. Also added under provisioner files are the zip of the webapp and the systemd service file with the commands to execute and start the ec2 server for the ec2-user.

Steps to run the project:

Raise a pull request from the fork branch to the organization main in the webapp repository with any small change

The above PR will trigger a github workflow to merge pull which will inturn start the actions to invoke the packer file to run the ami.pkr.hcl.

The successful completion of actions will result in an AMI being created in the dev aws console as per the github secret keys and variables set.

The AMI created is to be copied on to the var.tfvars of the clones aws-infra repository.

Terraform apply command with var.tfvars file will create the ec2 instance in the dev/demo aws console account as per required inputs with the associated AMI created.

The AMI created in dev is also shared with the demo account using the account id configured while running the packer template file.

The public IP is to be copies onto the postman and run the APIs as required to test the application functionalities

A server is setup in localhost on port 3000 as default. The port environment variable can be configured as required before running the server.

To test the API end points, open Postman and execute the below POST API

Configure the method as 'POST' Enter http://{public_IP_of_EC2}:3000/v1/user in the request url
Add first_name, last_name, username (email id), password in the json format in the request body and click send.
The details entered except for the password are displayed in the response along with additional autogenerated fields like id, account_created and account_updated
GET API 4. Configure the method as 'GET' Enter http://{public_IP_of_EC2}:3000/v1/user/{ID} in the request url 5. Set the authorization to basic authentication and enter the registered username as the email id and the password 6. Also, add the id of the user in the url and click send to get the data

PUT API

Configure the method as 'PUT' Enter http://{public_IP_of_EC2}:3000/v1/user/{ID} in the request url

Set the authorization to basic authentication and enter the registered username as the email id and the password

Also, add the id of the user in the url

The user will only be able to update the first_name, last_name and the password.

Click send to update the data in the database

The data will get updated in the table as requested

The RESTful API Endpoints implemented for products are

POST - to add new products to the table in the database POST is used. The values to be given in JSON are name, description, sku, manufacturer and quantity. API address is http://{public_IP_of_EC2}:3000/v1/product. If any one field is missing then the error message is "Incomplete Data". Basic authorization is used to check if the user exists. Only existing/authorized users can post the products.

GET - to view all the values present in the table GET is used. sku of the particular product should be given in the url for the POSTMAN to show the response. API address will be http://{public_IP_of_EC2}:3000/v1/product/{sku}. no authentication is done here.

PUT/PATCH - to update the values like name, description, sku, quantity and manufacturer PUT/PATCH is used. sku should be a unique value. Basic authorization should happen successfully when a user wants to update the values. API address will be http://{public_IP_of_EC2}:3000/v1/product/{sku}. The values that need to be updated should be given in the json format. The response for this call is the 'Data is Updated' message. Only user who creates the product can update the details

DELETE - to delete the row in the table products basic authentication have to be successful and only user who creates the product can delete it. API address will be http://{public_IP_of_EC2}:3000/v1/product/{sku}.

Assignment5

In this assignment we are adding 4 new routes in our web application

POST : v1/product/productID/image -> to post a new image

GET : v1/product/productID/image -> to get all images

GET : v1/product/productID/image/imageId -> to get specific image

DELETE : v1/product/productID/image/imageId -> to delete a specific image

When we post and delete images , they should get uploaded and deleted in the S3 bucket in Aws ec2 instance

This assignment should ensure that our app runs in the ec2 instance and get connected to the rds instance..
