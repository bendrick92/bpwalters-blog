#!/bin/bash
# 
# Cleans and deploys the project to S3.
#
# Usage:
#   ./deploy.sh <ACCESS_KEY> <SECRET_KEY>

# Initialize some vars
export AWS_ACCESS_KEY_ID="$1"
export AWS_SECRET_ACCESS_KEY="$2"
export BUCKET="blog.bpwalters.com"
export DEPLOY_DIR=".deploy"

# Build jekyll
jekyll build

# CBuild temporary directory
mkdir -p $DEPLOY_DIR
mkdir -p $DEPLOY_DIR/posts

# Copy _site files to $DEPLOY_DIR
rsync -av _site/. $DEPLOY_DIR --exclude=*.sh

for filename in $DEPLOY_DIR/*.html; do
    if [ $filename != "$DEPLOY_DIR/index.html" ];
    then
        original="$filename"

        # Get the filename without the path/extension
        filename=$(basename "$filename")
        extension="${filename##*.}"
        filename="${filename%.*}"

        # Move it
        mv $original $DEPLOY_DIR/posts/$filename
    fi
done

# Clear S3 bucket
aws s3 rm s3://$BUCKET/.

# Upload everything but posts
aws s3 cp "$DEPLOY_DIR" s3://$BUCKET --recursive --exclude "posts/*" --acl public-read

# Finally, upload the posts specifically to force the content-type
aws s3 cp "$DEPLOY_DIR/posts" s3://$BUCKET --recursive --content-type "text/html" --acl public-read

# Cleanup
rm -r $DEPLOY_DIR