#!/bin/sh

# should we do our start up things
if [ ! -d "/git/.git" ]; then

  if [ -n "$GIT_SYNC_FORCE_ACCEPT_SSH_KOST_KEY" ]; then
    ssh-keyscan $GIT_SYNC_FORCE_ACCEPT_SSH_KOST_KEY >> ~/.ssh/known_hosts
  fi

  # perform a sparse checkout
  cd /git
  git init
  git remote add origin $GIT_SYNC_REPO
  git fetch
  git reset --hard origin/master
  #git pull origin master

  # did the user pass a directory inside the GIT repo?
  if [ -n "$GIT_SYNC_RELATIVE_DIRECTORY" ]; then
    # request sparse checkout
    ln -s "/git/$GIT_SYNC_RELATIVE_DIRECTORY" /export
  fi

fi

exec "$@"
