stopifnot(any("datasets" %in% ls()))

# download data ----

if(datasets$ionosphere){
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

if(datasets$monash){
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

if(datasets$nab){
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

if(datasets$ucr){
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
