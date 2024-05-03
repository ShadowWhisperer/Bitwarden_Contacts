#!/bin/bash

Source="$1"

clear; echo

#Check file for issues
if [[ -z "$Source" ]]; then echo 'Source file not set'; echo; exit; fi
if [[ ! -f "$Source" ]]; then echo 'Source file does not exist'; echo; exit; fi
if ! grep -qm 1 '\,' "$Source"; then echo 'Source file is no a CSV'; echo; exit; fi


#Beginning of file
echo '{
  "encrypted": false,
  "items": [' > /tmp/data


##############################
# Get variables
##############################
IFS=''; while read -r Line; do
Col1="$(cut -d , -f 1 <<< "$Line")" # Name
Col2="$(cut -d , -f 2 <<< "$Line")" # Number 1
Col3="$(cut -d , -f 3 <<< "$Line")" # Number 2
Col4="$(cut -d , -f 4 <<< "$Line")" # Number 3
Col5="$(cut -d , -f 5 <<< "$Line")" # Number 4
Col6="$(cut -d , -f 6 <<< "$Line")" # Number 5
if [[ -z "$Col3" ]]; then Col3='null'; fi #Number2
if [[ -z "$Col4" ]]; then Col4='null'; fi #Number3
if [[ -z "$Col5" ]]; then Col5='null'; fi #Number4
if [[ -z "$Col6" ]]; then Col6='null'; fi #Number5
##############################

#Main Data
echo "

    {
      \"passwordHistory\": null,
      \"deletedDate\": null,
      \"organizationId\": null,
      \"type\": 4,
      \"reprompt\": 0,
      \"name\": \"$Col1\",
      \"notes\": null,
      \"favorite\": false,
      \"fields\": [
        {
          \"name\": \"Phone 2\",
          \"value\": \"$Col3\",
          \"type\": 0,
          \"linkedId\": null
        },
        {
          \"name\": \"Phone 3\",
          \"value\": \"$Col4\",
          \"type\": 0,
          \"linkedId\": null
        },
        {
          \"name\": \"Phone 4\",
          \"value\": \"$Col5\",
          \"type\": 0,
          \"linkedId\": null
        },
        {
          \"name\": \"Phone 5\",
          \"value\": \"$Col6\",
          \"type\": 0,
          \"linkedId\": null
        }
      ],
      \"identity\": {
        \"title\": null,
        \"firstName\": null,
        \"middleName\": null,
        \"lastName\": null,
        \"address1\": null,
        \"address2\": null,
        \"address3\": null,
        \"city\": null,
        \"state\": null,
        \"postalCode\": null,
        \"country\": null,
        \"company\": null,
        \"email\": null,
        \"phone\": \"$Col2\",
        \"ssn\": null,
        \"username\": null,
        \"passportNumber\": null,
        \"licenseNumber\": null
      },
      \"collectionIds\": null
    },
    
" >> /tmp/data
echo >>  /tmp/data
done < "$Source"


#Remove very last ,
sed '/^\s*$/d' /tmp/data | head -n -1 > /tmp/data.json

#Ending
echo '

    }
  ]
}

' | grep . >> /tmp/data.json

rm /tmp/data
chmod 777 /tmp/data.json

echo
echo 'File saved:  /tmp/data.json'
echo
echo
