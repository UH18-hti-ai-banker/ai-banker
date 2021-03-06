hockeyStickUI <- function(id) {
  ns <- NS(id)

  actionLink <- function(inputId, ...) {
    tags$a(href='javascript:void',
           id=inputId,
           class='action-button',
           ...)
  }

  fluidPage(
    titlePanel("Ennuste"),
    fluidRow(
      column(3,
             wellPanel(
               h4(""),
               sliderInput(ns("xtra"), "Säästöt Kuukaudessa",
                           0, 1200, 200, step = 10)#,
             )
      ),
      column(9,
             plotlyOutput(ns("plot"))
      )
    )
  )
}

hockeyStickS <- function(input, output, session) {

  #Specifying the specs
  valNames <- c("Tili", "Asunto", "Asuntolaina", "Rahasto")
  values <- c(1400, 160000, 100000, 0)
  names(values) <- valNames
  interests <- c(0, 2, 2, 6)
  names(interests) <- valNames
  flowNames <- c("Palkka", "Menot", "Lainalyhennys")
  flows <- c(2000, 800, 800)
  names(flows) <- flowNames
  specs <- list(values, interests, flows)
  names(specs) <- c("Alku", "Korko", "Virrat")

  output$plot <- renderPlotly({

      expenditure <- specs$Virrat["Palkka"] - specs$Virrat["Lainalyhennys"] - input$xtra
      specs$Virrat["Menot"] <- expenditure

      series <- hockeyStick(specs)

      ggplot(data = series) +
        geom_line(aes(as.Date(Date), Invest, col = 3)) +
        #geom_line(aes(as.Date(Date), Keep), col = 2) +
        xlab("") +
        ylab("€") +
        ylim(c(0,200000)) +
        theme(axis.text.y = element_text(angle=45, size = 9, vjust = 1, hjust = 1)) +
        theme(legend.position = "none")

    })

}
