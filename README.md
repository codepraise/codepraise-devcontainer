# CodePraise DevContainer
Environment setup is always a nightmare for a new member who has just onboard to the project. It takes time to install all the necessary tools, compiler or interpreter, version control system, or database. Therefore, a DevContainer can standardize the developing environment for developers to start working on a new project in a short time.

## Installation
Clone this repo to your working machine which has already installed docker.

## Usage
### Setup the ENV variable
Change the `.env-example` file to `.env`, then set up the value of `PASSWD` as your user's password.

### Start the DevContainer
Run the `start-devcontainer.sh` to start the DevContainer.
```
script/start-devcontainer.sh
```

After logging into the DevContainer, the working directory will be `~/workspace/projects`, this is the place where we can clone the `codepraise-api` and `codepraise` repo.

### Remove the DevContainer
Run the `remove-devcontainer.sh` to remove the DevContainer.
```
script/remove-devcontainer.sh
```
