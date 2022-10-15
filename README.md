# CodePraise DevContainer
Environment setup is always a nightmare for a new member who has just onboard to the project. It takes time to install all the necessary tools, compiler or interpreter, version control system, or database. Therefore, a DevContainer can standardize the developing environment for developers to start working on a new project in a short time.

## Installation
Clone this repo to your working machine which has already installed docker.

## Usage
### Setup the ENV variable
Change the `.env-example` file to `.env`.

### Accessorize the DevContainer Shell
You can customize the shell environment by adding some commands in `.devcontainer/profile.sh`, like `alias`. 

### Start the DevContainer
Run the `start-devcontainer.sh` to start the DevContainer and login to the shell.
```
script/start-devcontainer.sh
```
It will automatically clone all the projects we specified from `project_github_urls` in `config.yml`. Also execute `bundle install` for all projects.

#### Get Another Shell in the DevContainer
You can get another shell in the DevContainer by opening a new terminal then run the `start-devcontainer.sh`

#### Working Directory
After logging into the DevContainer shell, the working directory will be `~/workspace/projects`, this is the place where we cloned the project.
```
-- workspace
   |-- projects
   |    |-- codepraise
   |    |   |-- ...
   |    |-- codepraise-api
   |    |   |-- ...
   |    |-- ...
   |-- ...   
```

#### Architecture of the DevContainer
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

> **Note**
> If it fails to remove or stop the container, try to restart docker then remove or stop it again.

## Data Storage
Some folders on our local machine are mapped to containers for caching data storage, so that the data won't be lost even if we remove the DevContainer.

### Project
The `projects` folder on our local machine is mapped to the `~/workspace/projects/` in the `host` container. So we can edit them on our local machine directly, and it will synchronize to the `host` container automatically.
```
-- codepraise-devcontainer
   |-- projects
   |   |-- codepraise
   |   |   |-- ...
   |   |   codepraise-api
   |   |   |-- ...
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
   |   |   |-- ...
   |   |-- redis
   |   |   |-- ...
   |-- ...
```

### Gem Packages
The gem package data will only be stored in the `host` container, since it will lower the running speed of the program in the `host` container if we want to read/write them from the local machine. 
Therefore, everytime you run the `start-devcontainer.sh` to start the DevContainer and login to the shell, it will execute `bundle install` command to install gem packages automatically.
