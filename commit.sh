#!/bin/bash

if [ "$#" -ne 2 ]; then #check paramters
    echo "Usage: $0 <TASKID> <Appended_Dev_Message>"
    exit 1
fi

TASKID=$1
APPENDED_DEV_MSG=$2
CSV_FILE="task.csv" 

#check if the csv exist
if [ ! -f "$CSV_FILE" ]; then
    echo "Error: File $CSV_FILE does not exist."
    exit 1
fi

#search the mission in the csv
FOUND=false
while IFS=',' read -r CSV_TASKID DESC BRANCH DEVELOPER GITHUB_URL; do
    if [ "$CSV_TASKID" == "$TASKID" ]; then
        FOUND=true
        CURRENT_DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
        COMMIT_MSG="$TASKID – $CURRENT_DATETIME – $BRANCH – $DEVELOPER – $DESC – $APPENDED_DEV_MSG"

        #branch
        git checkout "$BRANCH" || git checkout -b "$BRANCH"

        #Commit
        git add .
        git commit -m "$COMMIT_MSG"

        #Push to github read me
        git push -u "$GITHUB_URL" "$BRANCH"
        if [ $? -eq 0 ]; then
            echo "Commit and push succeeded for TaskID $TASKID."
        else
            echo "Commit and push failed for TaskID $TASKID."
        fi
    fi
done < "$CSV_FILE"

if [ "$FOUND" == "false" ]; then
    echo "Error: TaskID $TASKID not found in $CSV_FILE."
    exit 1
fi
