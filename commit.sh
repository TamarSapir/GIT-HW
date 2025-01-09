#!/bin/bash

if [ "$#" -ne 1 ]; then #check paramters
    echo "Usage: $0 <input_csv_file>"
    exit 1
fi

#according the tesk the code will get just two parametrs 
CSV_FILE=$1

#check if there are csv file
if [ ! -f "$CSV_FILE" ]; then
    echo "Error: File $CSV_FILE does not exist."
    exit 1
fi

#reading the scv
while IFS=',' read -r TASKID DESC BRANCH DEVELOPER GITHUB_URL; do
    if [ "$TASKID" == "TaskID" ]; then
        continue
    fi

    CURRENT_DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
    COMMIT_MSG="$TASKID – $CURRENT_DATETIME – $BRANCH – $DEVELOPER – $DESC"

    #branch
    git checkout "$BRANCH" || git checkout -b "$BRANCH"

    #commit
    git add .
    git commit -m "$COMMIT_MSG"

    #push
    git push "$GITHUB_URL" "$BRANCH"
    if [ $? -eq 0 ]; then
        echo "Commit and push succeeded for TaskID $TASKID."
    else
        echo "Commit and push failed for TaskID $TASKID."
    fi

done < "$CSV_FILE"