fundsTableUI <- function(id) {
  ns <- NS(id)

  dataTableOutput(ns("table"))
}

fundsTable <- function(input, output, session, data) {
  output$table <- renderDataTable(data)
}
