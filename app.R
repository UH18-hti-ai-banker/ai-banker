library(shiny)

source("R/api.R")
source("R/OPpayment.R")
source("modules/costplot.R")
source("modules/funds.R")
source("modules/OPpayment.R")
source("modules/questions.R")

# Initialize API
api_op_funds <- API_OP_FUNDS()

# Define UI for app
ui <- {
  navbarPage(img(src="AIBanker_logo.jpeg", height="100%"),
             tabPanel("Costs", costPlotUI("costs")),
             tabPanel("Payments", OPpaymentUI("oppayment", Total_assets)),
             tabPanel("Funds", fundsTableUI("funds")),
             tabPanel("Questions", questionsUI("questions")),
             windowTitle = "AI-Banker")
}

# Define server logic
server <- function(input, output, session) {

  output$costs <- callModule(costPlot, "costs")
  output$oppayment <- callModule(OPpayment, "oppayment", Total_assets)
  output$funds <- callModule(fundsTable, "funds", api_op_funds)
  callModule(questions, "questions")

}

shinyApp(ui = ui, server = server)
