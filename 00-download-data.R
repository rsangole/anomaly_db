library(tidyverse)

cli::cli_inform("You're working in {here::here()}")

# configure ----

datasets_to_download <- list(
  ionosphere = T,
  nab = T,
  monash = T, #2G download, 7G uncompressed
  ucr = T
)

# dir and git setup ----

# create large_data if does not exist
if(!fs::dir_exists(here::here("large_data"))){
  cli::cli_alert("{here::here('large_data')} does not exist")
  resp <- usethis::ui_yeah("Create {here::here('large_data')}?", yes = "Y", no = "N", shuffle = F)
  if(!resp)
    stop()
  fs::dir_create(here::here("large_data"))
}

if(fs::dir_exists(here::here(".git")) & !fs::file_exists(here::here(".gitignore"))){
  cli::cli_alert_danger("You have a git project, but no .gitignore. You must add {here::here('large_data')} to .gitignore since the data are massive.")
  stop()
}

if(fs::file_exists(here::here(".gitignore")) &
   !any(grepl("large_data", readLines(here::here(".gitignore"))))){
  cli::cli_alert_danger("Your .gitignore does not have `large_data` specified. Add this to continue, since the data are massive.")
  stop()
  }

# download data ----

if(datasets_to_download$ionosphere){
  DIR <- here::here("large_data/ionosphere")
  resp <- T
  if(fs::dir_exists(DIR)){
    resp <- usethis::ui_yeah("{DIR} already exists. Re-download data?", "Y", "N", shuffle = F)
  }
  if(resp){
    fs::dir_create(DIR)
    download.file(url = "https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data",
                  destfile = glue::glue("{DIR}/ionosphere.data"))
    download.file(url = "https://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.names",
                  destfile = glue::glue("{DIR}/ionosphere.names"))
  }
}

if(datasets_to_download$monash){
  DIR <- here::here("large_data/monash")
  resp <- T
  if(fs::dir_exists(DIR)){
    resp <- usethis::ui_yeah("{DIR} already exists. Re-download data?", "Y", "N", shuffle = F)
  }
  if(resp){
    timeout.existing <- getOption("timeout")
    on.exit(options(timeout = timeout.existing))
    options(timeout = 60*60)
    download.file(url = "https://ndownloader.figshare.com/files/14338235",
                  destfile = here::here("large_data/monash"))
    unzip(zipfile = here::here("large_data/monash"), exdir = here::here("large_data"))
    fs::file_delete(here::here("large_data/monash"))
    system(command = glue::glue('mv {here::here("large_data/Datasets_12338")} {here::here("large_data/monash")}'))
  }
}

if(datasets_to_download$nab){
  DIR <- here::here("large_data/nab_data")
  resp <- T
  if(fs::dir_exists(DIR)){
    resp <- usethis::ui_yeah("{DIR} already exists. Re-download data?", "Y", "N", shuffle = F)
    fs::dir_delete(here::here("large_data/nab_data"))
  }
  if(resp){
    timeout.existing <- getOption("timeout")
    on.exit(options(timeout = timeout.existing))
    options(timeout = 60*60)
    download.file(url = "https://github.com/numenta/NAB/archive/refs/heads/master.zip",
                  destfile = here::here("large_data/master.zip"))
    unzip(zipfile = here::here("large_data/master.zip"), exdir = here::here("large_data"))
    fs::file_delete(here::here("large_data/master.zip"))
    fs::dir_copy(path = here::here("large_data/NAB-master/data"),
                 new_path = here::here("large_data"))
    system(command = glue::glue('mv {here::here("large_data/data")} {here::here("large_data/nab_data")}'))
    fs::dir_delete(here::here("large_data/NAB-master"))
  }
}

if(datasets_to_download$ucr){
  DIR <- here::here("large_data/UCRArchive_2018")
  resp <- T
  if(fs::dir_exists(DIR)){
    resp <- usethis::ui_yeah("{DIR} already exists. Re-download data?", "Y", "N", shuffle = F)
    fs::dir_delete(here::here("large_data/UCRArchive_2018"))
  }
  if(resp){
    download.file(url = "https://www.cs.ucr.edu/%7Eeamonn/time_series_data_2018/UCRArchive_2018.zip",
                  destfile = here::here("large_data/UCRArchive_2018.zip"))
    system(command = glue::glue('unzip -P someone {here::here("large_data/UCRArchive_2018.zip")} -d {here::here("large_data")}'))
    fs::file_delete(here::here("large_data/UCRArchive_2018.zip"))
  }
}


rstudioapi::navigateToFile(here::here("01-load-data-to-postgres.R"))
