#!/bin/bash

git=/usr/local/bin/git

BRANCH=$(git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

if [ "$BRANCH" != "develop" ]
then
  echo "You are currently on the $BRANCH branch."
  echo "Please change to the develop branch before running this script."
  echo "Don't forget to commit and merge your changes first."
  echo "Use do_feature_merge.sh to perform this task."
  exit 1
fi

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

if [ "$MESSAGE" == "" ]
then
  echo "Please provide a commit message -m parameter"
  exit 1
fi

# make sure we're on the develop branch
git checkout develop

NOW=$(date +"%Y%m%d %T")
FILE="VERSION"

echo "$NOW" > $FILE

git commit --all -m "$MESSAGE"

git push origin develop

git checkout master
git merge --no-edit --no-ff develop
git push origin master

# and move back to the develop branch
git checkout develop

NOW=$(date +"%Y%m%d")

echo "git commits performed and returned to develop branch"
echo "To deploy..."
echo "run the do_deploy script, with a message value using -m"
echo ""
echo "To cut more code..."
echo "git checkout -b 'weekly_work_commencing_$NOW'"
