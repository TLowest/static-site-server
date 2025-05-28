#!/bin/bash

# === Configuration ===
KEY_PATH="<path-to-your-ssh-key>"
USER="ec2-user"
HOST="<your-ec2-ip>"
LOCAL_DIR="my-website/"
REMOTE_DIR="/usr/share/nginx/html"
TMP_DIR="/tmp/deploy-temp"

# === Function to run commands safely ===
run_or_exit() {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "Error executing: $*"
        exit $status
    fi
}

# === Deploy Script ===
echo "Starting deployment to $USER@$HOST..."

# Step 1: Rsync files to temporary location on remote server
run_or_exit rsync -avz -e "ssh -i $KEY_PATH" "$LOCAL_DIR" "$USER@$HOST:$TMP_DIR"

# Step 2: SSH into server to move files and configure permissions
ssh -i $KEY_PATH $USER@$HOST << EOF
  set -e

  echo "Ensuring remote directory exists..."
  sudo mkdir -p $REMOTE_DIR

  echo "Cleaning up old files..."
  sudo rm -rf $REMOTE_DIR/*

  echo "Copying new files..."
  sudo cp -r $TMP_DIR/* $REMOTE_DIR/

  echo "Setting correct permissions..."
  sudo chown -R nginx:nginx $REMOTE_DIR
  sudo find $REMOTE_DIR -type d -exec chmod 755 {} \;
  sudo find $REMOTE_DIR -type f -exec chmod 644 {} \;

  echo "Restarting nginx..."
  sudo systemctl restart nginx

  echo "Deployment complete. Site is live at: http://$HOST"
EOF
