# *DOGIPRESS* by Novadart
This project has the goal to make it easier to use develop and deploy Wordpress projects while using Docker and Git.

It's very much work in progress, if you have suggestions we encourage you to contribute with a PR.

## Quick Setup

1. Download a copy of this project setup from `https://github.com/Novadart/dogipress/archive/master.zip`

2. Remove the files/directories that will not belong to your project:
    * README.md
    * .git/
    
3. Configuration:
    
    A. If you plan to save everything (Wordpress files, database, uploads directory) in git you don't need to configure anything.
    
    B. If you plan to **NOT** save the database and/or the uploads files in git you need to:
       
      * create a file `local.env` using `local.env.template` as template and modify it to point to the directory where you keep the `wp-content/uploads` files
      * open `docker-compose.yml` and uncomment the line
          ```yml
          - ${WP_UPLOADS_DIR}:/var/www/html/wp-content/uploads
          ```
        this way during development the files will be sourced from that directory
      * add `db/` to `.gitignore`
          
    **NOTE:** you can add custom php options in `config/php.ini`. You might need to install custom php extensions, to do so check Dockerfile and the official PHP docker image docs https://store.docker.com/images/php?tab=description 

4. [**Only once**] Generate the wordpress files by opening a console and running:
    ```
    $ ./start.sh && ./stop.sh && ./start.sh && ./stop.sh
    ```
    This will create the files, save a copy of the db and fix permissions to your user.
    It will ask you the password (runs sudo in `./start.sh`)
    
5. Commit and push the stub of your website to your repo


## Development Phase
1. Execute:
  ```
  ./start.sh
  ```
2. Make changes to your Wordpress site
3. Execute:
  ```
  ./stop.sh
  ```
4. Commit and push changes to your git repo

**NOTE:** if you chose not to save the DB and/or the uploads direcotry content on GIT, you should save them manually too because yoir Wordpress site won't work if they are not available


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
    * on the server load it
    ```
    docker load -i my-website-1.2.3.tar
    ```
    
3. Deploy it using either a custom `docker-compose.yml` or by manually running `docker run`.

**NOTE:** If you're using docker for the DB too don't forget to set a volume for your database or you'll lose all of your data whenever you reboot the instance.