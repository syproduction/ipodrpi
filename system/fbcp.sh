#!/bin/bash

sudo /usr/local/bin/fbcp &
sudo killall click
sleep 1
sudo /usr/local/bin/fbcp &
