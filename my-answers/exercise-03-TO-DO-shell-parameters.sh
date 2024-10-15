#!/bin/bash

# Check if the user is root, otherwise exits with status 1
if [[ ${UID} -ne 0 ]]
then
  echo "This script should be executed as root."
  exit 1
fi

# The first parameter is the login name
LOGIN_NAME="${1}"

# The rest of positional parameters are treated as the comment for the account
shift
COMMENT="${@}"

# Test if the user has provided the correct parameters
if [[ -z ${LOGIN_NAME} || -z ${COMMENT} ]]
then
    echo -e "\nUsage: sudo ./add-local-user.sh <loginname> <comment>\n"
    exit 1
fi

# TODO Randomly generates a password









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
