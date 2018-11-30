library(shiny)

source("R/opapi.R")
source("modules/example.R")
source("modules/funds.R")

# Initialize API
api <- OPAPI()

# Define UI for app
ui <- htmlTemplate("layout/application.html",
  plotexample = exampleplotUI("example"),
  funds = fundsTableUI("funds")
)

# Define server logic
server <- function(input, output, session) {

  output$example <- callModule(exampleplot, "example")

  funds <- getFunds(api)
  output$funds <- callModule(fundsTable, "funds", funds)

}

shinyApp(ui = ui, server = server)
