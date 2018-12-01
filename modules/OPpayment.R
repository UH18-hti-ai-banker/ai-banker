
OPpaymentUI<-function(id, data) {
  ns <- NS(id)

  filters <- fluidRow(column(3,
                          selectInput(ns("bank"),
                                      "Bank:",
                                      c("All",
                                        as.character(unique(data$Bank))))),
                      column(3,
                             selectInput(ns("payment"),
                                         "Payment:",
                                         c("All",
                                           as.character(unique(data$payment))))),
                      column(3,
                             selectInput(ns("subject"),
                                         "Subject:",
                                         c("All",
                                           as.character(unique(data$subject)))))
                      )

  htmlTemplate("layout/oppayment.html", filters = filters, table = dataTableOutput(ns("table")))

}

OPpayment <- function(input, output, session, data) {
  output$table <- renderDataTable({
    filtered <- data
    if (input$bank != "All") {
      filtered <- filtered[filtered$Bank == input$bank,]
    }
    if (input$payment != "All") {
      filtered <- filtered[filtered$payment == input$payment,]
    }
    if (input$subject != "All") {
      filtered <- filtered[filtered$subject == input$subject,]
    }
    filtered
    })
}
