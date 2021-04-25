#!/bin/bash

echo  -e "\nWhat file path are you looking for?\n"

sleep 3

read file

sleep 3

if [ -f ${file} ]

then

echo -e  "\nit is a valid file with filepath as follows:\n"

sleep 3

find / -name ${file}

sleep 3

else

echo -e "\nit is not a valid file\n"

fi

