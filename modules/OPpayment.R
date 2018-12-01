# The user-interface definition of the Shiny web app.
library(shiny)
library(BH)
require(markdown)
require(data.table)
library(dplyr)
library(DT)


OPpaymentUI<-function(id) {
  (navbarPage("Payments",
              tabPanel("Explore your expenditures",))
  )

}




###### testi
ui <- fluidPage(
  titlePanel("Payments"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("Dateinput", "Date", start = 2017, end = 2018, min = min(Total_assets$Date),
                     max = max(Total_assets$Date), format = "yyyy-mm-dd", startview = "month"),
      radioButtons("SubjectInput", "Subject type",
                   choices = c(unique(Total_assets$subject)),
                   selected = ),
      selectInput("costInput", "Expenditures",
                  choices = c(unique(Total_assets$payment)))
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      tableOutput("results")
  )
)

server <- function(input, output) {}
shinyApp(ui = ui, server = server)
