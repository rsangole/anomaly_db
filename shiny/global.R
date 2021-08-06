# install.packages("foreign")
library("tidyverse")
library("DBI")
library("progress")
library("shiny")
library("plotly")

# DB Connection ----
con <- DBI::dbConnect(
  drv = RPostgres::Postgres(),
  dbname = "anomaly",
  host = "db",
  user = "rahul",
  password = "pass",
  port = 5432
)

ucr_tables <- con %>% dbListTables() %>% grep("^ucr", x = ., value = T)
nab_tables <- con %>% dbListTables() %>% grep("^nab", x = ., value = T)
