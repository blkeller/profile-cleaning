#!/bin/bash

echo -e \\n"***********************************************"
echo "Profile Clean Utility for Medill School"
echo "Written by Brett Keller"
echo "***********************************************"

if [[ `whoami` == "hansel" ]]
   then echo -e \\n"Currently logged in as hansel."
   else echo -e \\n"This script only runs under the hansel account."\\n"Please logout and login as hansel."\\n && exit
fi

if [[ `sudo whoami` == "root" ]]
   then echo -e \\n"Administrator privileges granted."\\n
   else echo -e \\n"Unable to establish administrator privileges."\\n"Please run this script again with the correct password."\\n && exit
fi

UserList=`sudo dscl . list /Users | grep -Ev "_|root|daemon|nobody|hansel|dummylocalaccount"`

for u in $UserList ; do
   echo "Deleting $u..."
   sudo dscl . delete /Users/$u
   sudo rm -rf /Users/$u
   sudo rm -rf /Library/Managed\ Preferences/$u
done

echo -e \\n"Profile cleaning is complete.  Please reboot the computer."
