#!/usr/bin/env bash

HOST=$1
PORT=$2

ssh-keygen -R [$HOST]:$PORT
ssh-keyscan -p $PORT $HOST >> ~/.ssh/known_hosts