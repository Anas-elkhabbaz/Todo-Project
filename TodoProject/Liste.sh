#!/bin/bash

info() {
    if [ -f "todolist.json" ]; then
        # Utiliser jq pour extraire chaque élément du tableau tasks
        jq -c '.tasks[]' todolist.json | while IFS= read -r task; do
            # Afficher chaque tâche
            echo "Task:"
            echo "$task"

            # Utiliser jq pour filtrer les champs et appliquer une condition
            filtered_task=$(jq '{id: .id, title: .title, description: .description, location: .location, time: .time, date: .date, task_state: .task_state} | select(.title != "Exclure")' <<< "$task")

            # Afficher la tâche filtrée
            echo "Task after filtering:"
            echo "$filtered_task"

            echo "---"
        done
    else
        echo "Le fichier todolist.json n'existe pas."
    fi
}

info

