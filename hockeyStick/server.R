library(shiny)
library(ggplot2)
library(dplyr)

source("/Users/jetroanttonen/ai-banker/R/hockeyStick.r")

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

# Set up handles to database tables on app start
#db <- src_sqlite("movies.db")
#omdb <- tbl(db, "omdb")
#tomatoes <- tbl(db, "tomatoes")

# Join tables, filtering out those with <10 reviews, and select specified columns
#all_movies <- inner_join(omdb, tomatoes, by = "ID") %>%
#  filter(Reviews >= 10) %>%
#  select(ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre, Released,
#         Director, Writer, imdbRating, imdbVotes, Language, Country, Oscars,
#         Rating = Rating.y, Meter, Reviews, Fresh, Rotten, userMeter, userRating, userReviews,
#         BoxOffice, Production, Cast)


function(input, output, session) {

  # Filter the movies, returning a data frame
  #series <- reactive({#
#
#    expenditure <- specs$Virrat["Palkka"] - specs$Virrat["Lainalyhennys"] - input$xtra
#    specs$Virrat["Menot"] <- expenditure#
#
#    hockeyStick(specs)#
#
#  })

  output$plot <- renderPlot({

    expenditure <- specs$Virrat["Palkka"] - specs$Virrat["Lainalyhennys"] - input$xtra
    specs$Virrat["Menot"] <- expenditure

    series <- hockeyStick(specs)

    ggplot(data = series) +
      geom_line(aes(as.Date(Date), Invest, col = 3)) +
      geom_line(aes(as.Date(Date), Keep), col = 2) +
      xlab("Päivämäärä") +
      ylab("Tuotot (€)") +
      ylim(c(0,200000)) +
      legend(c("Rahasto", "Käteinen"))

 }) #, height=700

}
