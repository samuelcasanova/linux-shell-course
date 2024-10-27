#!/bin/bash

usage_and_exit() {
    echo -e "\nUsage: sudo ./remove-local-user.sh [options] LOGIN1 LOGIN2 ..." >&2
    echo -e "Options:" >&2
    echo -e "    -d" >&2
    echo -e "        Deletes the users in the list\n" >&2
    echo -e "    -r" >&2
    echo -e "        Removes the home directory associated with the account\n" >&2
    echo -e "    -a" >&2
    echo -e "        Archive the home directory content in /tmp\n" >&2
    exit 1
}

# Check if the user is root, otherwise exits with status 1
if [[ ${UID} -ne 0 ]]
then
  echo "This script should be executed as root." >&2
  exit 1
fi

# Read all options from the command line
while getopts dra OPTION
do
    case ${OPTION} in
        d) DELETE_USER='true' ;;
        r) REMOVE_HOME_DIRECTORY='true' ;;
        a) ARCHIVE_HOME_DIRECTORY='true' ;;
        ?) usage_and_exit ;;
    esac
done

# Remove the processed opts to process the rest of parameters
shift $(( OPTIND - 1 ))

# The rest of parameters should be a list of at least one user
if [[ "${#}" -lt 1 ]]
then
    usage_and_exit
fi

# Loop through the list of users to process the operations indicated in the options
for USERNAME in "${@}" 
do
    if [[ $(id -u ${USERNAME}) -lt 1000 ]]
    then
        echo "User ${USERNAME} is a protected system account and can not be deleted with this script" >&2
        exit 1
    fi

    echo "Processing actions for user ${USERNAME}:"

    if [[ ${DELETE_USER} = 'true' ]]
    then
        echo "Deleting the user ${USERNAME}..."
    fi

    if [[ ${REMOVE_HOME_DIRECTORY} = 'true' ]]
    then
        echo "Removing the home directory for the user ${USERNAME}..." 
    fi

    if [[ ${ARCHIVE_HOME_DIRECTORY} = 'true' ]]
    then
        echo "Archiving the home directory for the user ${USERNAME}..."
    fi
done
