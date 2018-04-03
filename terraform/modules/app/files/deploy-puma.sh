#!/bin/bash
set -x

APP_DIR=${1:-$HOME}

git clone -b monolith https://github.com/express42/reddit.git
cd $APP_DIR/reddit && bundle install
sudo cp /tmp/puma.service /etc/systemd/system/
sudo systemctl enable puma
sudo systemctl start puma

