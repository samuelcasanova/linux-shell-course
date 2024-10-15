#!/bin/bash

# Check if the user is root, otherwise exits with status 1
if [[ ${UID} -ne 0 ]]
then
  echo "This script should be executed as root."
  exit 1
fi

read -p "Enter the login for the new user: " LOGIN

if [[ -z ${LOGIN} ]]
then
    echo "The login can't be empty"
    exit 1
fi

read -p "Enter the username for the new user: " USER_NAME

if [[ -z ${USER_NAME} ]]
then
    echo "The username can't be empty"
    exit 1
fi

read -p "Enter the password for the new user: " PASSWORD

if [[ -z ${PASSWORD} ]]
then
    echo "The password can't be empty"
    exit 1
fi

# Creates the user with the provided login and username
useradd -c ${USER_NAME} ${LOGIN}

# Checks if the user creation command was successful, otherwise exits with status 1
if [[ "${?}" -ne 0 ]]
then
    echo "The account was not created for any reason"
    exit 1
fi

# Displays the username, the password and the hostname
echo "Successfully created the login ${LOGIN} with password ${PASSWORD} in hostname ${HOSTNAME}"
