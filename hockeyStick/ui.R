library(shiny)

# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

fluidPage(
  titlePanel("Profiiiiit!"),
  fluidRow(
    column(3,
           wellPanel(
             h4("Filter"),
             sliderInput("xtra", "Kuinka paljon investoitavissa?",
                         0, 1200, 200, step = 10)#,
                   )
    ),
    column(9,
           plotOutput('plot')
           )
  )
)
