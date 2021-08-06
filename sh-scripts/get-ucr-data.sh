# /bin/sh

curl https://www.cs.ucr.edu/%7Eeamonn/time_series_data_2018/UCRArchive_2018.zip \
  --output UCRArchive_2018.zip
unzip -P someone UCRArchive_2018.zip -d ../large_data/ucr_archive
rm -rf UCRArchive_2018.zip
