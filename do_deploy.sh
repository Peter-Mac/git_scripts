#!/bin/bash

git=/usr/local/bin/git

if [[ $# -eq 0 ]] ; then
  echo "Please provide an environment value [staging|production]"
  exit 1
fi

environment="$1"

echo "-----------------"
echo "checkout master..."
git checkout master
echo "starting deploy..."
bundle exec cap $1 deploy
echo "...deploy ended"
echo "and moving back to develop branch"
git checkout develop
echo "on branch develop...now get more stuff done"
echo "-----------------"
