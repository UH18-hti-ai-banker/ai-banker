library(shiny)

source("R/opapi.R")
source("R/OPpayment.R")
source("modules/costplot.R")
source("modules/funds.R")
source("modules/OPpayment.R")

# Initialize API
api <- OPAPI()

# Define UI for app
ui <- htmlTemplate("layout/application.html",
  costplot = costPlotUI("costs"),
  oppayment = OPpaymentUI("oppayment", Total_assets),
  funds = fundsTableUI("funds")
)

# Define server logic
server <- function(input, output, session) {

  output$costs <- callModule(costPlot, "costs")
  output$oppayment <- callModule(OPpayment, "oppayment", Total_assets)
  funds <- getFunds(api)
  output$funds <- callModule(fundsTable, "funds", funds)

}

shinyApp(ui = ui, server = server)
