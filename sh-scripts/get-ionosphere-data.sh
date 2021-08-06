# /bin/sh
mkdir ../large_data/ionosphere
curl https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data \
  --output ../large_data/ionosphere/ionosphere.data
curl  https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.names\
  --output ../large_data/ionosphere/ionosphere.names
