# git_scripts


## Overview

I use git, github and the Ruby on Rails capistrano  gem to help manage my workflow.

The scripts contained here are handy one liners that help speed up my workflow so I dont really have to think too hard when I'm doing something that's repetitive.

## My Workflow

I do all of my development on feature branches that are then merged back to the 'develop' branch. 

The develop branch is used to collate work from multiple devs before pushing to the 'master' branch.

The master branch is then used to push code for release to either a staging server or a production server.

Capistrano is used to connect to each server and act as the deployment mechanism. This way I can deploy to remote servers, watch the script working its way through the full code and database migration process.

## The scripts

### do_feature_merge.sh
This script allows you to

- merge your current feature branch back into the 'develop' branch

- provide a merge comment

- create a new feature branch, or stay with the develop branch as active

### do_release.sh
This script is used to push your local changes to the remote github repository and to provide a comment for the changes.

### do_deploy.sh
This is the script responsible for executing the capistrano deployment tasks. It takes an environment value as parameter (either 'staging' or 'production').

- It updates a VERSION file with the date and time of this release, checks the VERSION file into github,

- It starts the capistrano deployment tasks

- It checks out the develop branch ready for you to create your next feature branch   
