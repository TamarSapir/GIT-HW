#!/bin/bash

if [ "$#" -lt 2 ]; then #check the paramters
    echo "Usage: $0 <TASKID> <Dev Message> [--push] [<REPO>]"
    exit 1
fi

#according the tesk the code will get just two parametrs 
TASKID=$1
DEV_MSG=$2
PUSH=false  
REPO_PATH="." #this folder

for arg in "$@"; do #check if we can push
    if [ "$arg" == "--push" ]; then
        PUSH=true
    elif [[ ! "$arg" == "$1" && ! "$arg" == "$2" && ! "$arg" == "--push" ]]; then
        REPO_PATH="$arg"
    fi
done

#check if the folder wxist
if [ ! -d "$REPO_PATH/.git" ]; then
    echo "Error: $REPO_PATH is not a valid Git repository."
    exit 1
fi

cd "$REPO_PATH" || exit

CURRENT_DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
BRANCH_NAME=$(git branch --show-current)
DEV_NAME="TAMAR SAPIR" 
TASK_DESC="Create README.md file" 

#commit
COMMIT_MSG="$TASKID – $CURRENT_DATETIME – $BRANCH_NAME – $DEV_NAME – $TASK_DESC – $DEV_MSG"

git add .
git commit -m "$COMMIT_MSG"