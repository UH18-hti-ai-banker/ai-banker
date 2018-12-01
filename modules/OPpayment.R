
OPpaymentUI<-function(id) {
  ns <- NS(id)

  div(
    h1("Payments"),
    dataTableOutput(ns("table"))
  )
}

OPpayment <- function(input, output, session, data) {
  output$table <- renderDataTable(data)
}
