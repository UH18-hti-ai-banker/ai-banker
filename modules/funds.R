fundsTableUI <- function(id) {
  ns <- NS(id)

  dataTableOutput(ns("table"))
}

fundsTable <- function(input, output, session, api) {
  #funds <- GET(api, "funds")
  funds <- readRDS("fundsNew.rds")
  output$table <- renderDataTable(funds)
}
