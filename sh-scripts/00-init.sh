# /bin/sh

# create directory if does not exist
if [ -d "../large_data" ] 
then
    echo "Directory ../large_data exists." 
else
    echo "Error: Directory ../large_data not exists."
    mkdir -p ../large_data
fi
