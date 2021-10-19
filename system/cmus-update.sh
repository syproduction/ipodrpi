#!/bin/bash
#:bind -f common u shell ~/Applications/cmus-osx/update-library.sh
#:set softvol=true
cmus-remote -C clear
cmus-remote -C "add ~/Music"
cmus-remote -C "update-cache -f"


