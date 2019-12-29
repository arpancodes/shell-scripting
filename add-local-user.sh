#!/bin/bash

# Enforce superuser privileges
if [[ ${UID} -ne 0 ]]
then
    echo "You are not a superuser."
    exit 1
fi

# Prompt user for username
read -p 'Enter username: ' USERNAME

# Prompt user for FULL NAME
read -p 'Who will use this account?: ' FULLNAME

# Prompt user for the password
read -p 'Enter password: ' PASSWORD

# Add user
useradd -c "${FULLNAME}" -m ${USERNAME}
if [[ ${?} -ne 0 ]]
then
    echo "Unfortunately, account was not created. Please try again."
    exit 1
fi

echo "A new account for ${FULLNAME} was created successfully."

# Set password for the user
echo "${USERNAME}:${PASSWORD}" | chpasswd

# Force user to change password on first login
passwd -e ${USERNAME}

exit 0