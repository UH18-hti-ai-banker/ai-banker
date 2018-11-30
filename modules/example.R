exampleplotUI <- function(id) {
  ns <- NS(id)

  slider <- sliderInput(inputId = ns("bins"), label = "Number of bins:", min = 1, max = 50, value = 30)
  plot <- plotOutput(outputId = ns("plot"))

  htmlTemplate("layout/example.html", slider = slider, plot = plot)
}

exampleplot <- function(input, output, session) {
  output$plot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

  })
}
