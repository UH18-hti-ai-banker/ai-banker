# Get dependencies
library(shiny)
library(jsonlite)
library(plotly)
library(readxl)
library(plyr)
library(ggplot2)
library(dplyr)
library(pdftools)

# Source included libraries
source("R/api.R")
source("R/OPpayment.R")
source("R/hockeyStick.R")
source("modules/costplot.R")
source("modules/funds.R")
source("modules/payments.R")
source("modules/questions.R")
source("modules/hockeystick.R")

# Define UI for app
ui <- {
  navbarPage(img(src="AIBanker_logo.jpeg", height="100%"),
             tabPanel("Costs", costPlotUI("costs")),
             tabPanel("Payments", paymentsUI("payments")),
             tabPanel("Funds", fundsTableUI("funds")),
             tabPanel("Questions", questionsUI("questions")),
             tabPanel("Hockey stick", hockeyStickUI("hockeystick")),
             windowTitle = "AI-Banker")
}

# Define server logic
server <- function(input, output, session) {

  # Initialize personal API
  api_op_funds <- API_OP_FUNDS()

  output$costs <- callModule(costPlot, "costs")
  output$oppayment <- callModule(payments, "payments")
  output$funds <- callModule(fundsTable, "funds", api_op_funds)
  callModule(questions, "questions")
  output$hockeystick <- callModule(hockeyStickS, "hockeystick")

}

shinyApp(ui = ui, server = server)
