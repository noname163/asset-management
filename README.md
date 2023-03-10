﻿# Welcome to asset-management
 Asset management website was created to help the company manage their assets and allow employees to create requests to borrow or return assets. This project has two roles, an admin role, user role. Admin role can create, delete, edit, search, filter assets or accounts in their location, and accept return requests. User role can create request assets, return assets and view their own asset they have borrowed.
 # Installation guide
 ## Software requirement
 - Database(Required): 
  - PostgresSQL: Follow instruction to install [PostgresSQL.docs](https://www.postgresql.org/docs/current/tutorial-install.html)
 ## Install dependence 
**JDK 11**
- Follow instructions to install the latest version of JDK [oracle docs](https://docs.oracle.com/en/java/javase/11/install/overview-jdk-installation.html#GUID-8677A77F-231A-40F7-98B9-1FD0B48C346A)

**Maven**
- Follow instruction to setup and install [Maven](https://maven.apache.org/install.html)
## Environment variable setup
You need to add six environment variable in your local machine to run project
- DB_URL: This environment variable is url connect to your database
- DB_USERNAME: This environment variable is your database user
- DB_PASSWORD: This environment variable is your database password 
- ALLOWED_ORIGINS: This environment variable is the domain that you want to allow to connect with backend
- JWT_SECRET_KEY: This environment variable is a string to decode the token
- JWT_EXPIRES_TIME: this environment variable is a long integer bigger than 1000

## Run Project
- Download, open project name "swp_project" in CMD on windows or terminal in IOS and run command `mvn spring-boot:run` to run project
## End point
### User-controller
#### PUT /api/user/edit 
- General
  - Edit user with request body similar to the one below
  
    ```
    {
      "dateOfBirth": "string",
      "gender": "MALE",
      "joinedDate": "string",
      "type": "ADMIN",
      "staffCode": "string"
    }
    ```

  - Return an UserResponseDto object similar to the one below
  
    ```
    {
      "id": 0,
      "username": "string",
      "staffCode": "string",
      "firstName": "string",
      "lastName": "string",
      "gender": "MALE",
      "joinedDate": "2023-01-01T09:59:25.240Z",
      "dateOfBirth": "2023-01-01T09:59:25.240Z",
      "type": "ADMIN",
      "location": "string",
      "fullName": "string",
      "firstLogin": true
    }
    ```
  