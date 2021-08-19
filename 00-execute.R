library("tidyverse")
library("foreign")
library("DBI")
library("progress")

cli::cli_inform("You're working in {here::here()}")

# configure ----

datasets <- list(
  ionosphere = TRUE,
  nab = TRUE,
  monash = TRUE,
  #2G download, 7G uncompressed
  ucr = TRUE
)

# dir and git setup ----

# create large_data/ if does not exist
if (!fs::dir_exists(here::here("large_data"))) {
  cli::cli_alert("{here::here('large_data')} does not exist")
  resp <-
    usethis::ui_yeah(
      "Create {here::here('large_data')}?",
      yes = "Y",
      no = "N",
      shuffle = F
    )
  if (!resp)
    stop()
  fs::dir_create(here::here("large_data"))
}

# git but no gitignore?
if (fs::dir_exists(here::here(".git")) &
    !fs::file_exists(here::here(".gitignore"))) {
  cli::cli_alert_danger(
    "You have a git project, but no .gitignore. You must add {here::here('large_data')} to .gitignore since the data are massive."
  )
  stop()
}

# gitignore but large_data missing?
if (fs::file_exists(here::here(".gitignore")) &
    !any(grepl("large_data", readLines(here::here(".gitignore"))))) {
  cli::cli_alert_danger(
    "Your .gitignore does not have `large_data` specified. Add this to continue, since the data are massive."
  )
  stop()
}

source(here::here("01-download-data.R"))
source(here::here("02-load-data-to-postgres.R"))
