costPlotUI <- function(id) {
  ns <- NS(id)
  div(
    plotlyOutput(ns("wealth")),
    plotlyOutput(ns("costs"))
  )
}

costPlot <- function(input, output, session) {
  output$costs <- renderPlotly({
    CostsPlot
  })
  output$wealth <- renderPlotly({
    WealthPlot
  })
}
