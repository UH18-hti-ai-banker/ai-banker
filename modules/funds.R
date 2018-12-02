fundsTableUI <- function(id) {
  ns <- NS(id)

  dataTableOutput(ns("table"))
}

fundsTable <- function(input, output, session, api) {
  funds <- GET(api, "funds")
  output$table <- renderDataTable(funds)
}
