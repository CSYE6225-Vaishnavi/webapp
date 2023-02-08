Assignment 1

Implemented node.js framework to develop back-end application and Postgres SQL database to store user data.

As per the requirements 3 API's are created to create, use and modify database information with the help of back-end application.

1. POST : User is expected to submit his first_name, last_name, email-id(used as username) and password. This information is then pushed to the database to users table. ID, account_created, account_updated timestamp fields are updated with system time when a user is created with the API
POST API address: http://localhost:3000/v1/user

2. PUT : User will be given the option to update his information in the database. email-id(username) is an exception. To update the information user will have to authenticate with their username and password. Errors will be triggered accordingly if the information pushed by user is incorrect.
PUT API address: http://localhost:3000/v1/user/{id}

3. GET : API will return the user details that are stored in the user table in the database. User will be required to complete basic authentication with his username and password to view his record.
GET API address: http://localhost:3000/v1/user/{id}

Postman API tool is leveraged to trigger the API's to make calls to the database table.

In VS code open the project folder and run "npm install" command to install the node.js dependencies. To run the application open the terminal in the VS code and run "npm start" command. This will create a server in local instance on port number 3000(default). .
