# An GIT-sync Docker image

[![Docker Stars](https://img.shields.io/docker/stars/martinvw/git-sync.svg)](https://hub.docker.com/r/martinvw/git-sync/)  [![Docker Pulls](https://img.shields.io/docker/pulls/martinvw/git-sync.svg)](https://hub.docker.com/r/martinvw/git-sync/)  [![Docker Automated buil](https://img.shields.io/docker/automated/martinvw/git-sync.svg)](https://hub.docker.com/r/martinvw/git-sync/)  ![GitHub forks](https://img.shields.io/github/forks/martinvw/docker-git-sync.svg?style=social&label=Fork) ![GitHub stars](https://img.shields.io/github/stars/martinvw/docker-git-sync.svg?style=social&label=Star)

Docker which periodically updates from a remote git location

## Supported tags and respective ```Dockerfile``` links

* latest ([Dockerfile](https://raw.githubusercontent.com/martinvw/docker-git-sync/master/Dockerfile))

This image is updated via pull requests to the [martinvw/docker-git-sync](https://github.com/martinvw/docker-git-sync) GitHub repo.

## What is this GIT-sync Docker image

It's just a docker which periodically updates from a remote git location

## How to use the image (command line)

> $ docker run --name git-sync -d -e GIT\_SYNC\_REPO="https://github.com/martinvw/resume.git" martinvw/git-sync

## Using Docker-compose

Create the following ```docker-compose.yml``` and start the container with ```docker-compose up -d```

```
version: "3"

services:
   gitsync:
      image: martinvw/git-sync
      restart: always
      environment:
        GIT_SYNC_REPO: ssh://git@gitlab:22/martinvw/resume.git
        GIT_SYNC_FORCE_ACCEPT_SSH_KOST_KEY: gitlab_web_1.nginx-proxy
        GIT_SYNC_RELATIVE_DIRECTORY: Website
       volumes:
         - 'website_sources:/git/Website:z'
         - './restricted_rsa.pub:/root/.ssh/id_rsa.pub'
         - './restricted_rsa:/root/.ssh/id_rsa'
       restart: always
   
   nginx:
      image: 'nginx:latest'
      depends_on:
       - gitsync
      volumes:
       - 'website_sources:/usr/share/nginx/html:ro'
      restart: always

volumes:
  website_sources:
    driver: local

networks:
  default:
    external:
      name: nginx-proxy
```

Used together with [jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy) and [jrcs/letsencrypt-nginx-proxy-companion](https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion).

## Supported Docker versions

This image is officially supported on Docker version 1.13.1.

Support for older versions (down to 1.6) is provided on a best-effort basis.

## User Feedback

### Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/martinvw/docker-git-sync/issues).

### Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/martinvw/docker-git-sync/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

## Documentation

## License

When not explicitly set, files are placed under [![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)
