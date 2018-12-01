costPlotUI <- function(id) {
  ns <- NS(id)
  div(
    plotlyOutput(ns("wealth")),
    plotlyOutput(ns("costs"))
  )
}

costPlot <- function(input, output, session) {
  output$costs <- renderPlotly({
    getCostsPlot()
  })
  output$wealth <- renderPlotly({
    getWealthPlot()
  })
}
