#!/bin/bash
set -e
BUILD_DATE="`date +%Y%m%d`"

# build configs
# ===============================
APP_GIT_BRANCH="master"
APP_GIT_HTTP="https://gitlab.terhaak.de/jojo/anime-metadata-cache.git"

# APP image name
# ===============================
APP_IMG_REPO="reg.lan.terhaak.de/jojo"
APP_IMG_NAME="anime-metadata-cache-app"
APP_IMG_REV="1" # revision for multiple releases per day

APP_IMG_TAG="$BUILD_DATE-$APP_IMG_REV"
APP_IMG_FQN="$APP_IMG_REPO/$APP_IMG_NAME:$APP_IMG_TAG"

# REDIS image name
# ===============================

REDIS_IMG_REPO="reg.lan.terhaak.de/jojo"
REDIS_IMG_NAME="anime-metadata-cache-redis"
REDIS_IMG_REV="1" # revision for multiple releases per day

REDIS_IMG_TAG="$BUILD_DATE-$REDIS_IMG_REV"
REDIS_IMG_FQN="$REDIS_IMG_REPO/$REDIS_IMG_NAME:$REDIS_IMG_TAG"


# BUILDS
# ===============================

echo -e "\n** Building APP image **\n"
sudo docker build -t "$APP_IMG_FQN" \
  --build-arg GIT_BRANCH="$APP_GIT_BRANCH" \
  --build-arg GIT_HTTP="$APP_GIT_HTTP" \
  ./docker/app

echo -e "\n** Building REDIS image **\n"
sudo docker build -t "$REDIS_IMG_FQN" \
  ./docker/redis

echo -e "\n** Successfully build following images: **\n"
echo -e "$APP_IMG_FQN"
echo -e "$REDIS_IMG_FQN"
