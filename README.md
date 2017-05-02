# *DOGIPRESS*
This project has the goal to make it easier to use develop and deploy Wordpress projects while using Docker and Git.

It's very much work in progress, if you have suggestions we encourage you to contribute with a PR.

## Requirements
This project was tested on a Linux environment. The following tools are required:

* Docker CE (latest)
* Docker Compose (latest)
* mysqldump


## Quick Setup

1. Download a copy of this project setup from `https://github.com/Novadart/dogipress/archive/master.zip`

2. Remove the files/directories that will not belong to your project:
    * README.md
    * .git/
    
3. Configuration:
    
    A. If you plan to save everything (Wordpress files, database, uploads directory) in git you don't need to configure anything.
    
    B. If you plan to **NOT** save the database and/or the uploads files in git you need to:
       
      * create a file `local.env` using `local.env.template` as template and modify it to point to the directory where 
      you keep the `wp-content/uploads` files
      * open `docker-compose.yml` and uncomment the line
        ```
        - ${WP_UPLOADS_DIR}:/var/www/html/wp-content/uploads
        ```
        this way during development the files will be sourced from that directory
      * add `db/` to `.gitignore`
          
    **NOTE:** you can add custom php options in `config/php.ini`. You might need to install custom php extensions, to do 
    so check Dockerfile and the official PHP docker image docs https://store.docker.com/images/php?tab=description 

4. [**Only once**] Generate the wordpress files by opening a console and running (it will ask you the password):
    ```
    $ ./start.sh
    ```
    Open another console and run:
    ```
    $ ./stop.sh
    ```
    Then repeat start/stop again, to make sure that the permissions are correctly set.
    
    This will create the files, save a copy of the db and fix permissions to your user.
    
5. Commit and push the stub of your website to your repo


## Development Phase
1. [OPTIONAL] If you are working on an existing website you will need to place a copy of the DB in `./db` (make sure that 
the directory contains only 1 SQL file, since MariaDB will execute all of them) and place the content of `wp-content/uploads`
in the directory you defined in `local.env`
2. Execute:
  ```
  ./start.sh
  ```
3. Make changes to your Wordpress site
4. Execute:
  ```
  ./stop.sh
  ```
5. Commit and push changes to your git repo

**NOTE:** if you chose not to save the DB and/or the uploads directory content on GIT, remember to save them manually somewhere.


## Deployment Phase
1. Build your image
    ```
    docker build -t my-website:1.2.3 .
    ```

2. Manually upload your image on your deployment server
    * Save the image
    ```
    docker save -o /tmp/my-website-1.2.3.tar my-website:1.2.3

    ```
    * Upload it to the server via FTP
    * Log-in on the deployment server and load the image
    ```
    docker load -i my-website-1.2.3.tar
    ```
    
3. Deploy it using either a custom `docker-compose.yml` or by manually running `docker run`.

**NOTE:** unless your site is static and using an external DB, you will need to set the volumes for your uploads folder and 
the database data.