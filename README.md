# CodePraise DevContainer
Environment setup is always a nightmare for a new member who has just onboard to the project. It takes time to install all the necessary tools, compiler or interpreter, version control system, or database. Therefore, a DevContainer can standardize the developing environment for developers to start working on a new project in a short time.

## Installation
Clone this repo to your working machine which has already installed docker.

## Usage
### Setup the ENV variable
Change the `.env-example` file to `.env`, then set up the value of `PASSWD` as your user's password. The password can be used for like `sudo` command.

### Accessorize the DevContainer Shell
You can customize the shell environment by adding some commands in `.devcontainer/profile.sh`, like `alias`. 

### Start the DevContainer
Run the `start-devcontainer.sh` to start the DevContainer and login to the shell.
```
script/start-devcontainer.sh
```
You can get another shell in the DevContainer by opening a new terminal then run the `start-devcontainer.sh`

After logging into the DevContainer shell, the working directory will be `~/workspace/projects`, this is the place where we can clone the project we are going to develop, such as `codepraise-api` and `codepraise` repo.
```
-- workspace
   |-- projects
       |-- codepraise
       |   |-- ...
       |-- codepraise-api
           |-- ...
```

The DevContainer will start all the services we need as containers. 
* `host` is the container with the development environment setup already.
* `mongo`, `postgres`, and `redis` are containers with databases setup.
```
NAME                  COMMAND                  SERVICE             STATUS              PORTS
codepraise-host       "sleep infinity"         host                running             0.0.0.0:9090->9090/tcp, 0.0.0.0:9292->9292/tcp
codepraise-mongo      "docker-entrypoint.s…"   mongo-db            running             0.0.0.0:27017->27017/tcp
codepraise-postgres   "docker-entrypoint.s…"   postgres-db         running             0.0.0.0:5432->5432/tcp
codepraise-redis      "docker-entrypoint.s…"   redis-db            running             0.0.0.0:6379->6379/tcp
```

### Stop the DevContainer
Run the `stop-devcontainer.sh` to stop the DevContainer.
```
script/stop-devcontainer.sh
```

All the services will be stopped, and can be started again by running the `start-devcontainer.sh`.

### Remove the DevContainer
Run the `remove-devcontainer.sh` to remove the DevContainer.
```
script/remove-devcontainer.sh
```

All the services will be removed, it will create a whole new DevContainer environment if you run `start-devcontainer.sh` after removing the DevContainer. Therefore, only remove the DevContainer if you want to reset the environment, or if there are some changes to the setting of DevContainer in `.devcontainer/docker-compose.yml` or `.devcontainer/Dockerfile`.

## Data Storage
Some folders on our local machine are mapped to containers for caching data storage, so that the data won't be lost even if we remove the DevContainer.

### Project
The `projects` folder on our local machine is mapped to the `~/workspace/projects/` in the `host` container. So we can edit them on our local machine directly, and it will synchronize to the `host` container automatically.
```
-- codepraise-devcontainer
   |-- projects
   |   |-- codepraise
   |   |   |-- ...
   |   |-- codepraise-api
   |       |-- ...
   |-- ...
```

### Database
All the database (redis, mongo, postgres) data folders will be mapped in the `db-data` folder on our local machine.
```
-- codepraise-devcontainer
   |-- db-data
   |   |-- mongo
   |   |   |-- ...
   |   |-- postgres
   |       |-- ...
   |   |-- redis
   |       |-- ...
   |-- ...
```

### Bundle Packages
The bundle package data will only be stored in the `host` container, since it will lower the running speed of the program in the `host` container if we want to read/write them from the local machine. 
Hence, it requires the `bundle install` to install packages if you start the DevContainer for the first time or start a new DevContainer after removing the previous DevContainer.

