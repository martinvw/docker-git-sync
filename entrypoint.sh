#!/bin/bash -x

# start the cron deamon
cron

# should we do our start up things
if [ ! -d "/opt/git_repo" ]; then

  if [ -n "$FORCE_ACCEPT_SSH_KOST_KEY" ]; then
    ssh-keyscan $FORCE_ACCEPT_SSH_KOST_KEY >> ~/.ssh/known_hosts
  fi

  # do the initial checkout
  git clone $GIT_CLONE_URI /opt/git_repo

  # rm the default nginx folder
  rm -rf /usr/share/nginx/html

  # did the user pass a directory inside the GIT repo?
  if [ -n "$WEBSITE_DIRECTORY" ]; then
    # create the symlink to the website directory
    ln -s "/opt/git_repo/$WEBSITE_DIRECTORY" /usr/share/nginx/html
  fi

  # no directory was passed
  if [ -z "$WEBSITE_DIRECTORY" ]; then
    # create the symlink to the root of the GIT repo
    ln -s /opt/git_repo /usr/share/nginx/html
  fi
fi

exec "$@"
