#!/bin/bash
while true; do
echo "--------------Menu-----------------";
echo "Enter 1 to create a new task ";
echo "Enter 2 to update a new task ";
echo "Enter 3 to delete a new task ";
echo "Enter 4 to search a new task ";
echo "Enter 5 to print all tasks ";
echo "Enter 6 to print today's tasks";
echo "Enter 7 to quit";

read -p "Choose the number " x 

case $x in
    "1")
        source create.sh
        ;;
    "2")
        source update.sh
        ;;
    "3")
        source delete.sh
        ;;
    "4")
        source search.sh
        ;;
    "5")
        source Liste.sh
        ;;
    "6")
        source ListeDay.sh
        ;;
    "7")
        break;
        ;;
esac
done
