#!/bin/bash

sudo /usr/local/bin/fbcp &
sudo killall fbcp
sleep 1
sudo /usr/local/bin/fbcp &
