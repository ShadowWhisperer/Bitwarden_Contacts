Bash script that converts a contact CSV file into a json file, for Bitwarden to import as "Identity"

    ./convert.sh file.csv

Files saves to: **/tmp/data.json**

CSV format this script uses  
**Name, Phone, Phone, Phone, Phone, Phone**  
  
You will probably need adjustments, for however you plan to use it.  
Lines that does not contain data require "null"  

