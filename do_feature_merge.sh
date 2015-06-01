#!/bin/bash

MESSAGE=""
# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt m: "$@")
then
    # something went wrong, getopt will put out an error message for us
    exit 1
fi

eval set -- $options

until [ -z "$1" ]; do
    case $1 in
    -m ) MESSAGE="$MESSAGE $2"; shift;;
    -- ) shift; break;;
    -* ) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    * )  break;;
    esac
    shift
done

git=/usr/local/bin/git

BRANCH=$(git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

if [ "$BRANCH" == "develop" ]
then
  echo "You are currently on the $BRANCH branch."
  echo "Please change to your feature branch before running this command."
  exit 1
fi

if [ $MESSAGE == "" ]
then
  echo "Please provide a commit message using the -m flag"
  exit 1
fi

echo "You are currently on the $BRANCH branch..."

echo "###################################################################"
echo "This script will merge your feature branch with the develop branch" 
echo "It will then delete your feature branch and prompt you for the name"
echo "of a new feature branch."
echo "###################################################################"

echo "Updating timestamp..."
NOW=$(date +"%Y%m%d %T")
FILE="VERSION"

echo "$NOW" > $FILE

echo "Committing changes..."
git commit --all -m "$MESSAGE"

# make sure we're on the develop branch
echo "Checking out develop branch..."
git checkout develop

echo "Merging $BRANCH..."
git merge --no-edit --no-ff $BRANCH

echo "Deleting feature branch..."
git branch -d $BRANCH

echo "Input name of a new feature branch or just hit enter to stay in develop branch?" 
read NEWBRANCH 

if [[ "$NEWBRANCH" == "" ]] ; then
  echo "Finished"
  exit 0
else
  git checkout -b "$NEWBRANCH" develop
 echo "Now on new branch $NEWBRANCH...ready for work"
 exit 0
fi
