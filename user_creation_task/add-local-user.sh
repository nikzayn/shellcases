#!/bin/bash

#This script creates an account on the local system

#Check that if the user is root or not, if it's not a user
#then don't create a user just exit
if [[ "${UID}" -ne 0 ]]
then
    echo "You're not allowed to create a user, since you're not a superuser."
    exit 1
fi

#Prompt for the username
read -p 'Enter the username to create: ' USER_NAME

#Prompt for the name
read -p 'Enter the name of the person for which this account is for: ' COMMENT

#Prompt for the password
read -p 'Enter the password to use for this account: ' PASSWORD

#Create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

#Check to see if account was not able to created for some reason
if [[ "${?}" -ne 0 ]]
then
    echo 'The account could not be created. '
    exit 1
fi

#Set the password for the username
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
if [[ "${?}" -ne  0 ]]
then
    echo 'The password for the account could not be set.'
    exit 1
fi

#Force password changes on first login
passwd -e ${USER_NAME}

#Display the username, password and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0

