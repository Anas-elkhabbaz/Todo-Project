#!/bin/bash

update_task() {
    read -p "Enter the title of the task you want to update: " title

    if [ -f "todolist.json" ]; then
        # Use jq to find the task with the specified title
        task=$(jq --arg title "$title" '.tasks[] | select(.title == $title)' todolist.json)
        if [ -n "$task" ]; then
            echo "Found task: $task"

            # Prompt user for updated task details
            read -p "Give the new title to your task or press enter to skip: " new_title
            new_title=${new_title:-$(jq -r '.title' <<< "$task")}
            read -p "Description: " description
            description=${description:-$(jq -r '.description' <<< "$task")}
            read -p "Location: " location
            location=${location:-$(jq -r '.location' <<< "$task")}
            read -p "Date(YYYY-MM-dd): " date
            date=${date:-$(jq -r '.date' <<< "$task")}
            read -p "Time: " time
            time=${time:-$(jq -r '.time' <<< "$task")}
            read -p "Task state: (completed/not completed) " task_state
            task_state=${task_state:-$(jq -r '.task_state' <<< "$task")}

            # Create updated task object
            updated_task="{\"id\": $id, \"title\": \"$new_title\", \"description\": \"$description\", \
                           \"location\": \"$location\", \"time\": \"$time\", \"date\": \"$date\", \
                           \"task_state\": \"$task_state\"}"

            # Update task in the JSON file
            jq --argjson updated_task "$updated_task" '.tasks |= map(if .id == $updated_task.id then $updated_task else . end)' todolist.json > temp.json
            mv temp.json todolist.json
        else
            echo "Task not found with title: $title"
        fi
    fi
}

update_task

