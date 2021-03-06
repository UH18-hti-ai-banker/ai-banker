
paymentsUI<-function(id) {
  ns <- NS(id)

  data <- getTotal_assets()

  div(fluidRow(column(3,
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
                      ),
      dataTableOutput(ns("table"))
  )
}

payments <- function(input, output, session) {
  data <- getTotal_assets()
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
