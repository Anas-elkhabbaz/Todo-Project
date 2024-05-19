#!/bin/bash

create_task() {
    if [ -f "todolist.json" ]; then
        id=$(jq '.tasks[-1].id' todolist.json)
        ((id++))
    else
        id=0
    fi

    echo "Task ID: $id"

    while true; do 
        read -p "Give a title to your new task: " title
        task=$(jq --arg title "$title" '.tasks[] | select(.title == $title)' todolist.json)
        while [ -n "$task" ]
        do
           echo "This title already used choose a new name";
           read -p "Give the new title: " title
           task=$(jq --arg title "$title" '.tasks[] | select(.title == $title)' todolist.json)
        done
        if [[ -z "$title" ]]; then 
            echo "Title required"
        else 
            break
        fi 
    done

    read -p "Description: " description
    read -p "Location: " location

    while true; do 
        read -p "Date: (YYYY-MM-DD)" date
        read -p "Time: " time
        if [[ -z "$time" || -z "$date" ]]; then 
            echo "Time and date are required";
        else 
            break
        fi 
    done

    task_state="not completed" 

    new_task="{\"id\": $id, \"title\": \"$title\", \"description\": \"$description\", \
               \"location\": \"$location\", \"time\": \"$time\", \"date\": \"$date\", \
               \"task_state\": \"$task_state\"}"

    echo "New task JSON: $new_task"

    if [ -f "todolist.json" ]; then
        jq --argjson new_task "$new_task" '.tasks += [$new_task]' todolist.json > temp.json
        mv temp.json todolist.json
    else
        echo "{\"tasks\": [$new_task]}" > todolist.json
    fi
}

create_task

