stopifnot(any("datasets" %in% ls()))

# DB Connection ----
con <- DBI::dbConnect(
  drv = RPostgres::Postgres(),
  dbname = "anomaly",
  host = "db",
  user = "rahul",
  password = "pass",
  port = 5432
)

if (datasets$ionosphere) {
  dat <-
    read_csv("large_data/ionosphere/ionosphere.data", col_names = F) %>%
    rename(class = X35)
  DBI::dbWriteTable(con, "ionosphere", dat)
  con %>% dplyr::tbl("ionosphere")
  
}

if (datasets$monash) {
  # * abalone data ----
  files <- fs::dir_ls(path = "large_data/monash/", regexp = "abalone")
  dat <- map_df(files, ~ foreign::read.arff(.x)) %>%
    janitor::clean_names()
  dat %>% glimpse()
  DBI::dbWriteTable(con, "abalone", dat)
  con %>% dplyr::tbl("abalone")
  
  # * mice data ----
  files <- fs::dir_ls(path = "large_data/monash/", regexp = "mice")
  dat <- map_df(files, ~ foreign::read.arff(.x)) %>%
    janitor::clean_names()
  dat %>% glimpse()
  DBI::dbWriteTable(con, "mice", dat)
  con %>% dplyr::tbl("mice")
  
  # * HeartDisease_withoutdupl data ----
  files <-
    fs::dir_ls(path = "large_data/monash/", regexp = "HeartDisease_withoutdupl")
  dat <- map_df(files, ~ foreign::read.arff(.x)) %>%
    janitor::clean_names()
  dat %>% glimpse()
  DBI::dbWriteTable(con, "heartdisease_withoutdupl", dat)
  con %>% dplyr::tbl("heartdisease_withoutdupl")
  
  # * Parkinson_withoutdupl data ----
  files <-
    fs::dir_ls(path = "large_data/monash/", regexp = "Parkinson_withoutdupl")
  dat <- map_df(files, ~ foreign::read.arff(.x)) %>%
    janitor::clean_names()
  dat %>% glimpse()
  DBI::dbWriteTable(con, "parkinson_withoutdupl", dat)
  con %>% dplyr::tbl("parkinson_withoutdupl")
}

if (datasets$nab) {
  process_files <- function(dir) {
    file_ls <- fs::dir_ls(dir)
    cats <- fs::path_file(file_ls) %>% fs::path_ext_remove() %>%
      janitor::make_clean_names()
    map2_df(file_ls,
            cats,
            ~ readr::read_csv(file = .x) %>%
              mutate(cat = .y)) %>%
      rename(time = timestamp)
  }
  
  dat <- process_files("large_data/nab_data/realKnownCause/")
  dat %>% glimpse()
  DBI::dbWriteTable(con, "nab_realknowncause", dat, overwrite = T)
  con %>% dplyr::tbl("nab_realknowncause")
  
  dat <- process_files("large_data/nab_data/realTraffic/")
  dat %>% glimpse()
  DBI::dbWriteTable(con, "nab_realtraffic", dat, overwrite = T)
  con %>% dplyr::tbl("nab_realtraffic")
  
  dat <- process_files("large_data/nab_data/realTweets/")
  dat %>% glimpse()
  DBI::dbWriteTable(con, "nab_realtwitter", dat, overwrite = T)
  con %>% dplyr::tbl("nab_realtwitter")
  
  dat <- process_files("large_data/nab_data/realAdExchange/")
  dat %>% glimpse()
  DBI::dbWriteTable(con, "nab_realadexchange", dat, overwrite = T)
  con %>% dplyr::tbl("nab_realadexchange")
  
  dat <- process_files("large_data/nab_data/realAWSCloudwatch/")
  dat %>% glimpse()
  DBI::dbWriteTable(con, "nab_realcloudwatch", dat, overwrite = T)
  con %>% dplyr::tbl("nab_realcloudwatch")
  
  dat <- process_files("large_data/nab_data/artificialNoAnomaly/")
  dat %>% glimpse()
  DBI::dbWriteTable(con, "nab_artificial_noanomaly", dat, overwrite = T)
  con %>% dplyr::tbl("nab_artificial_noanomaly")
  
  dat <- process_files("large_data/nab_data/artificialWithAnomaly/")
  dat %>% glimpse()
  DBI::dbWriteTable(con, "nab_artificial_withanomaly", dat, overwrite = T)
  con %>% dplyr::tbl("nab_artificial_withanomaly")
}


if (datasets$ucr) {
  ucr_datasets <-
    fs::dir_ls("large_data/UCRArchive_2018/", type = "directory")
  
  read_ucr_data <- function(fname) {
    .part = ifelse(grepl("TRAIN", fname),
                   "train",
                   "test")
    
    dat <- data.table::fread(fname)
    dat[, id := 1:.N]
    names(dat) <- c("class", paste0("T", 1:(ncol(dat) - 2)), "id")
    dat %>%
      pivot_longer(starts_with("T"), names_to = "time") %>%
      mutate(time = as.numeric(gsub("T", "", time)),
             part = .part)
    
  }
  load_one_ucr_dataset <- function(.dir) {
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
  
  pb <- progress_bar$new(
    total = length(ucr_datasets),
    clear = FALSE,
    show_after = 0,
    format = "[:bar] :percent :db <rows = :nrow>"
  )
  walk(ucr_datasets, load_one_ucr_dataset)
  
  
  dbCreateTable(
    conn = con,
    name = "ucr_00_meta",
    fields = c("table" = "varchar",
               "meta" = "varchar")
  )
  load_one_ucr_meta <- function(.dir) {
    .db <- paste0("ucr_",
                  .dir %>%
                    fs::path_file() %>%
                    janitor::make_clean_names())
    md_doc <- fs::dir_ls(.dir, glob = "*.md")
    md_doc <- readr::read_file(md_doc)
    pb$tick(tokens = list(db = .db))
    DBI::dbWriteTable(
      conn = con,
      name = "ucr_00_meta",
      value = tibble(table = .db, meta = md_doc),
      append = TRUE
    )
    Sys.sleep(0.1)
  }
  pb <- progress_bar$new(
    total = length(ucr_datasets),
    clear = FALSE,
    show_after = 0,
    format = "[:bar] :percent :db"
  )
  walk(ucr_datasets, load_one_ucr_meta)
  
}


# # * VAST 2012 ---
# # NOTE - This dataset needs to be download manually-
# # https://www.vacommunity.org/tiki-index.php?page=VAST%20Challenge%202012%3A%20Challenge%20Descriptions
# # large_data/vast_2012/mc1/metaDB-csv-3-7
#
# files <- fs::dir_ls(path = "large_data/vast_2012/mc1/metaDB-csv-3-7/")
# meta_data <- read_csv(files[[1]])
# meta_data %>% glimpse()
# DBI::dbWriteTable(con, "vast2012_node_meta_data", meta_data)
# con %>% dplyr::tbl("vast2012_node_meta_data")
#
# node_health_ts <- data.table::fread(files[[2]]) #read_csv is too slow
# node_health_ts
# # write table fails for the whole table
# # splitting into chunks
# cuts <- cut(1:node_health_ts[,.N], breaks = 160, labels = F)
# node_health_ts[, split_id := cuts]
# # Writing the first 10 chunks (~ 10 mil rows)
# map(1:10,
#     ~ DBI::dbWriteTable(conn = con,
#                         name = "vast2012_node_health_ts",
#                         value = node_health_ts[split_id == .x][,-7],
#                         append = T)
#     )
# DBI::dbWriteTable(con, "vast2012_node_health_ts", node_health_ts)
# con %>% dplyr::tbl("vast2013_node_health_ts")