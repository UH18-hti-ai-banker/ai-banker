library(shiny)

op_api_token <- Sys.getenv("OP_API_TOKEN")

# Define UI for app that draws a histogram ----
ui <- htmlTemplate("layout/application.html",
  slider = htmlTemplate("layout/slider.html",
                        id = "bins",
                        label = "Number of bins:"),
  plotpart = htmlTemplate("layout/plotpart.html",
                          id = "distPlot")
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
  })
  
}

shinyApp(ui = ui, server = server)