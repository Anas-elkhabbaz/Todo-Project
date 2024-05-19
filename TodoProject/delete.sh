#!/bin/bash

delete_task() {
    read -p "Enter the title of the task you want to delete: " title
 if [ -f "todolist.json" ]; then
        # Use jq to find the task with the specified title
        task=$(jq --arg title "$title" '.tasks[] | select(.title == $title)' todolist.json)
            id=$(jq -r '.id' <<< "$task")
            echo "id: $id"

jq --arg id "$id" '.tasks |= map(select(.id != ($id | tonumber)))' todolist.json > temp.json && mv temp.json todolist.json

echo "the task doesnt exist anymore";
else
            echo "Task not found with title: $title"
        fi
}

delete_task
