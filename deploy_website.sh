#!/bin/bash

set -ex

TARGET_BRANCH=master
DIR=_site

rm -rf $DIR

# jekyll build
jekyll build

# Checkout and track the target branch
git checkout $TARGET_BRANCH

# Delete everything that isn't _site
ls | grep -E -v '^_site$' | xargs rm -rf

cp -R $DIR/* .

# Delete our temp folder
rm -rf $DIR

# Delete our temp folder
rm -rf .sass-cache

# Delete our temp folder
rm -rf .jekyll-metadata

# Stage all files in git and create a commit
git add -f assets/icon
git add .
git add -u
git commit -m "Website at $(date)"

# Push the new files up to GitHub
git push origin $TARGET_BRANCH

# return to website
git checkout website
