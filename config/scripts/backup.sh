#!/bin/bash
set -e;

source /.passphrase

cd "$(dirname "$0")"

FOLDER_TO_BACKUP=$1;
TARGET_FOLDER=$2;
SERVER_ADDR=$3


ARCHIVE=/tmp/$(date '+%Y-%m-%d-%H-%M-%S')-$(uuidgen).tar.gz

ssh -o StrictHostKeyChecking=no $SERVER_ADDR 'bash -s' < make_archive.sh $FOLDER_TO_BACKUP $ARCHIVE $GPG_PASSPHRASE

rsync -avz -e "ssh -o StrictHostKeyChecking=no" $SERVER_ADDR:$ARCHIVE.gpg $TARGET_FOLDER


