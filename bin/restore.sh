#!/bin/sh

# launch process to prevent sleep and move it to the background
pmset noidle &
# save the process ID
PMSETPID=$!

rsync -avz --exclude="\.Trash*" /Volumes/vance /Users/vance/

# kill pmset so the computer can sleep if it wants to
kill $PMSETPID
