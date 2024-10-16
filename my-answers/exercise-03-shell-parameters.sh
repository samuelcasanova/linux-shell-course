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

# Creates the user and checks it was succeded
useradd -c "${COMMENT}" ${LOGIN_NAME}

# Checks if the user creation command was successful, otherwise exits with status 1
if [[ "${?}" -ne 0 ]]
then
    echo "The account was not created, see above for additional error information"
    exit 1
fi

# Randomly generates a password
PASSWORD=$(date -Ins | md5sum | head -c 20)

# Sets the password for the user
echo "${LOGIN_NAME}:${PASSWORD}" | chpasswd

# Checks if changing the password was successful, otherwise exits with status 1
if [[ "${?}" -ne 0 ]]
then
    echo "The password could not be updated, see above for additional error information"
    exit 1
fi

#stdout the username, password, and hostname
echo "Successfully created the user with the following information:"
echo "Username: ${LOGIN_NAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"
