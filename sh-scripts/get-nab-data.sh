# /bin/sh
git clone git@github.com:numenta/NAB.git 
mkdir ../large_data/nab_datax
mv NAB/data/* ../large_data/nab_data
rm -rf NAB
