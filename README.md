# README

## Spin up dev environment

### 1. Install Docker and Docker compose

Verify you have docker compose installed by typing `docker compose -v` or
`docker-compose -v` in a terminal window (*keep note of how you access
docker compose, either `docker compose` or `docker-compose`, as this will
be required in following commands)

### 2. Build Container

The first time you launch this, you will need to first build the container
before running it (as we need to run rake commands).  In the terminal
window, run: `docker-compose build` from the root directory (same
directory as the `docker-compose.yaml` file).

### 3. Initialize the database

We need to populate and initialize the database before the application will run.  To do this, run the following command:

```bash
# Initialize the database
docker-compose run rails db:create db:migrate
```

### 4. Run the dev environment

Run this command to start up the dev environment.  Note, the `-d` flag
will run this in the background.  `docker-compose up -d`.

To stop (and teardown) the dev environment you just sun up, run
`docker-compose down`.  If you wish to spin the environment back up, you
will need to run step 3 and 4 again, as the database will have been
destroyed.

**Note:** If you wish to spin up and take down the environment but not
remove the containers between each spinup/teardown, run:
`docker-compose start -d` and `docker-compose stop`

---
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
