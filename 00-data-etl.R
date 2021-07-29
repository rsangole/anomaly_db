# install.packages("foreign")
library("foreign")
library("tidyverse")
library("DBI")

# DB Connection ----
con <- DBI::dbConnect(
  drv = RPostgres::Postgres(),
  dbname = "anomaly",
  host = "db",
  user = "rahul",
  password = "pass",
  port = 5432
)

# ODDS ----
# http://odds.cs.stonybrook.edu/

# * enron data
# https://www.cs.cmu.edu/~./enron/
# location: large_data/enron/

# * Numenta Anomaly Benchmark (NAB)
# https://github.com/numenta/NAB/tree/master/data
# location: large_data/nab_data



# MONASH ----
# https://figshare.com/articles/dataset/Datasets_12338_zip/7705127
# location : large_data/Datasets_12338

# * abalone data
files <- fs::dir_ls(path = "large_data/Datasets_12338/", regexp = "abalone")
dat <- map_df(files, ~foreign::read.arff(.x)) %>% 
  janitor::clean_names()
dat %>% glimpse()
DBI::dbWriteTable(con, "abalone", dat)
con %>% dplyr::tbl("abalone")

# * mice data
files <- fs::dir_ls(path = "large_data/Datasets_12338/", regexp = "mice")
dat <- map_df(files, ~foreign::read.arff(.x)) %>% 
  janitor::clean_names()
dat %>% glimpse()
DBI::dbWriteTable(con, "mice", dat)
con %>% dplyr::tbl("mice")


