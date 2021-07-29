# install.packages("foreign")
library("tidyverse")
library("DBI")
library("progress")

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

# * enron data ----
# https://www.cs.cmu.edu/~./enron/
# location: large_data/enron/

# * Numenta Anomaly Benchmark (NAB) ----
# https://github.com/numenta/NAB
# location: large_data/nab_data

process_files <- function(dir) {
  file_ls <- fs::dir_ls(dir)
  cats <- fs::path_file(file_ls) %>% fs::path_ext_remove() %>%
    janitor::make_clean_names()
  map2_df(file_ls, cats,
          ~ readr::read_csv(file = .x) %>%
            mutate(cat = .y))
}

dat <- process_files("large_data/nab_data/realKnownCause/")
dat %>% glimpse()
DBI::dbWriteTable(con, "nab_realknowncause", dat)
con %>% dplyr::tbl("nab_realknowncause")

dat <- process_files("large_data/nab_data/realTraffic/")
dat %>% glimpse()
DBI::dbWriteTable(con, "nab_realtraffic", dat)
con %>% dplyr::tbl("nab_realtraffic")

dat <- process_files("large_data/nab_data/realTweets/")
dat %>% glimpse()
DBI::dbWriteTable(con, "nab_realadexchange", dat)
con %>% dplyr::tbl("nab_realadexchange")

dat <- process_files("large_data/nab_data/realAdExchange/")
dat %>% glimpse()
DBI::dbWriteTable(con, "nab_realadexchange", dat)
con %>% dplyr::tbl("nab_realadexchange")

dat <- process_files("large_data/nab_data/realAWSCloudwatch/")
dat %>% glimpse()
DBI::dbWriteTable(con, "nab_realcloudwatch", dat)
con %>% dplyr::tbl("nab_realcloudwatch")

dat <- process_files("large_data/nab_data/artificialNoAnomaly/")
dat %>% glimpse()
DBI::dbWriteTable(con, "nab_artificial_noanomaly", dat)
con %>% dplyr::tbl("nab_artificial_noanomaly")

dat <- process_files("large_data/nab_data/artificialWithAnomaly/")
dat %>% glimpse()
DBI::dbWriteTable(con, "nab_artificial_withanomaly", dat)
con %>% dplyr::tbl("nab_artificial_withanomaly")

# * VAST 2012 ----
# https://www.vacommunity.org/tiki-index.php?page=VAST%20Challenge%202012%3A%20Challenge%20Descriptions
# large_data/vast_2012/mc1/metaDB-csv-3-7

files <- fs::dir_ls(path = "large_data/vast_2012/mc1/metaDB-csv-3-7/")
meta_data <- read_csv(files[[1]])
meta_data %>% glimpse()
DBI::dbWriteTable(con, "vast2012_node_meta_data", meta_data)
con %>% dplyr::tbl("vast2012_node_meta_data")

node_health_ts <- data.table::fread(files[[2]]) #read_csv is too slow
node_health_ts
# write table fails for the whole table
# splitting into chunks
cuts <- cut(1:node_health_ts[,.N], breaks = 160, labels = F)
node_health_ts[, split_id := cuts]
# Writing the first 10 chunks (~ 10 mil rows)
map(1:10,
    ~ DBI::dbWriteTable(conn = con, 
                        name = "vast2012_node_health_ts",
                        value = node_health_ts[split_id == .x][,-7],
                        append = T)
    )
DBI::dbWriteTable(con, "vast2012_node_health_ts", node_health_ts)
con %>% dplyr::tbl("vast2012_node_health_ts")

# * ionosphere ----
# http://odds.cs.stonybrook.edu/ionosphere-dataset/
# large_data/ionosphere
dat <- read_csv("large_data/ionosphere/ionosphere.data", col_names = F) %>% 
  rename(class = X35)
DBI::dbWriteTable(con, "ionosphere", dat)
con %>% dplyr::tbl("ionosphere")


# UCR ----
# https://www.cs.ucr.edu/%7Eeamonn/time_series_data_2018/
# large_data/ucr_archive

ucr_datasets <- fs::dir_ls("large_data/ucr_archive/", type = "directory")
ucr_datasets_names <- ucr_datasets %>% 
  fs::path_file() %>% 
  janitor::make_clean_names()

read_ucr_data <- function(fname){
  
  .part = ifelse(grepl("TRAIN", fname),
                 "train",
                 "test")
  
  dat <- data.table::fread(fname)
  dat[, id := 1:.N]
  names(dat) <- c("class", paste0("T", 1:(ncol(dat)-2)), "id")
  dat %>% 
    pivot_longer(starts_with("T"), names_to = "time") %>% 
    mutate(time = as.numeric(gsub("T", "", time)),
           part = .part)
  
}
load_one_ucr_dataset <- function(.dir){
  .db <- paste0("ucr_",
                .dir %>% 
                  fs::path_file() %>% 
                  janitor::make_clean_names())
  files <- rev(fs::dir_ls(.dir, glob = "*.tsv"))
  dat <- map_df(files, read_ucr_data)
  pb$tick(tokens = list(db = .db,
                        nrow = scales::label_comma()(nrow(dat))))
  DBI::dbWriteTable(con, .db, dat, overwrite = TRUE)
  Sys.sleep(0.1)
}

pb <- progress_bar$new(total = length(ucr_datasets),
                       clear = FALSE,
                       show_after = 0,
                       format = "[:bar] :percent :db <rows = :nrow>")
walk(ucr_datasets, load_one_ucr_dataset)

# MONASH ----
# https://figshare.com/articles/dataset/Datasets_12338_zip/7705127
# location : large_data/Datasets_12338

# * abalone data ----
files <- fs::dir_ls(path = "large_data/Datasets_12338/", regexp = "abalone")
dat <- map_df(files, ~foreign::read.arff(.x)) %>% 
  janitor::clean_names()
dat %>% glimpse()
DBI::dbWriteTable(con, "abalone", dat)
con %>% dplyr::tbl("abalone")

# * mice data ----
files <- fs::dir_ls(path = "large_data/Datasets_12338/", regexp = "mice")
dat <- map_df(files, ~foreign::read.arff(.x)) %>% 
  janitor::clean_names()
dat %>% glimpse()
DBI::dbWriteTable(con, "mice", dat)
con %>% dplyr::tbl("mice")


