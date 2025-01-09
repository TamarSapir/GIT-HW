#!/bin/bash

if [ "$#" -ne 2 ]; then #check the paramters
    echo "Usage: $0 <TASKID> <Dev Message>"
    exit 1
fi

#according the tesk the code will get just two parametrs 
TASKID=$1
DEV_MSG=$2

CURRENT_DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
BRANCH_NAME=$(git branch --show-current)
DEV_NAME="TAMAR SAPIR" 
TASK_DESC="Create README.md file" 

#commit
COMMIT_MSG="$TASKID – $CURRENT_DATETIME – $BRANCH_NAME – $DEV_NAME – $TASK_DESC – $DEV_MSG"

git add .
git commit -m "$COMMIT_MSG"