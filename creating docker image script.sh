#!/bin/bash


#############################################################################################################
#Author: emeke
#Description: A script with creating a dockerfile that will be used to run docker images
#Date: April, 2020
#############################################################################################################



#Building a dockerfile that will used to create the docker images using base OS "centos" or "ubuntu"

touch dockerfile

echo -e " \nWhat base OS do you want for the dockerfile, centos or ubuntu?\n"

read C

if

[ ${C} = centos ]

then

echo " FROM ${C}" >> dockerfile

elif

[ ${C} = ubuntu ]

then

echo " FROM ${C} " >> dockerfile

elif

[ ${C} != centos ] || [ ${C} != ubuntu ]

then

echo -e "\nPlease select a base OS for the dockerfile !\n"

exit 5

fi

#Exposing a port that the image will be listening from

echo -e "\n What Port do you want exposed\n"

read P

if

[ -n ${P} ] && [ ${P} -gt 0 ]

then

echo " EXPOSE ${P}" >> dockerfile

elif

[ -z ${P} ] || [ ${P} -le 0 ]

then

echo -e "\nPlease select a port greater than 0 !\n"

else

exit 3

fi

#Creating a copy path from our base OS

echo -e "\nNB: centos copy path = ./index.html /var/www/html ubuntu copy path = ./index.html /usr/locale/apache2/htdocs\n"
sleep 7

echo -e "\n What base os copy path do you want ? specify centos or ubuntu\n"

read COPY

if

[ $COPY = centos ]

then

echo " COPY ./index.html /var/www/html" >> dockerfile

elif

[ $COPY = ubuntu ]

then

echo " COPY  ./index.html /usr/locale/apache2/htdocs" >> dockerfile

elif

[ $COPY != centos ] && [ $COPY != ubuntu ]

then

echo -e "\nPlease specify a corresponding copy path\n"

exit 5

fi

#Creating a command that will keep the container from exiting when spun

echo -e "\nWhat CMD do you want spinning in the container; 'hello' or 'apache'\n"

read CMD

if

[ ${CMD} = apache ]

then

echo " CMD apachectl -D FOREGROUND " >> dockerfile

elif

[ ${CMD} = hello ]

then

echo ' CMD [ "echo", "hello world" ]' >> dockerfile

elif

[ ${CMD} != apache ] || [ ${CMD} != hello ]

then

echo -e "\n Please select a valid CMD\n"

else

exit 7

fi

echo -e "\nThe following then becomes our dockerfile.....\n"
sleep 2

echo "$(cat dockerfile)"
sleep 3

#Using the dockerfile to create a docker image

echo -e "\nCreating a docker image from our dockerfile....\n"

sleep 2

echo " What name do you want for the docker image ?"

read DI

if

[ -n ${DI} ]

then

docker build -t ${DI} .

elif

[ $? -eq 0 ]

then

echo "docker image built successfully"

elif

[ -z ${DI} ]

then

echo -e "Please select a name for the docker image!"

exit 8

fi

echo -e "\n Deleting the dockerfile.....\n"

sleep 2

rm -f dockerfile

if

[ $? -eq 0 ]

then

echo "dockerfile successfully deleted"

else

echo -e "dockerfile not deleted"

exit 6

fi


