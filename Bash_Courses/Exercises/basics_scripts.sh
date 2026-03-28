#!/bin/bash user_registration.sh

echo "1.register yourself"
echo "what is your first name"
read -r firstname
echo "what is your last name"
read -r lastname

echo "2. creating a new file..."
sleep 2

DATE=$(date +%d-%m-%Y)
echo "3.current date is : ${DATE}"
echo "$DATE" > output.txt
sleep 2

echo "4.writing your data in the output file..."
echo "firstname : ${firstname}" >> output.txt
echo "lastname : ${lastname}" >> output.txt
sleep 2

echo "5.creating backup file..."
cp output.txt backup.txt

sleep 2
echo "6.reading the output file"
cat < output.txt
