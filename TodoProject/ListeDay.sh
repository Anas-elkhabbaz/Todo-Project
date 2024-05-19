#!/bin/bash

listeDay() {
    Date=$(date +"%Y-%m-%d")
    echo "Today's date: $Date"  

    if [ -f "todolist.json" ]; then
    taskc=$(jq --arg date "$Date" '.tasks[] | select(.date == $date) | select(.task_state == "completed")' todolist.json)
    tasknc=$(jq --arg date "$Date" '.tasks[] | select(.date == $date) | select(.task_state == "not completed")' todolist.json)
    if [ -z "$taskc" ];then
    echo "There is no task completed";
    else
    echo "the task completed are :";
    echo "$taskc"
    fi
    if [ -z "$tasknc" ];then
    echo "There is no task not completed";
    else
    echo "the task not completed are :"
    echo "$tasknc"
    fi
    fi
}

listeDay

