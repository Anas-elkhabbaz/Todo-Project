#!/bin/bash

search_task() {
    read -p "Enter the title of the task you want to look for: " title

    if [ -f "todolist.json" ]; then
        task=$(jq --arg title "$title" '.tasks[] | select(.title == $title)' todolist.json)
        if [ -n "$task" ]; then
            echo "The task you are looking for is:\n$task"
        else
            echo "There is no task with this title."
        fi
    fi
}

search_task

           
