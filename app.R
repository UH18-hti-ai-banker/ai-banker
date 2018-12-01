library(shiny)

source("R/opapi.R")
source("R/OPpayment.R")
source("modules/example.R")
source("modules/funds.R")
source("modules/OPpayment.R")

# Initialize API
api <- OPAPI()

# Define UI for app
ui <- htmlTemplate("layout/application.html",
  plotexample = exampleplotUI("example"),
  oppayment = OPpaymentUI("oppayment", Total_assets),
  funds = fundsTableUI("funds")
)

# Define server logic
server <- function(input, output, session) {

  output$example <- callModule(exampleplot, "example")
  output$oppayment <- callModule(OPpayment, "oppayment", Total_assets)
  funds <- getFunds(api)
  output$funds <- callModule(fundsTable, "funds", funds)

}

shinyApp(ui = ui, server = server)
