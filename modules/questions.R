
questionsUI <- function(id) {
  ns <- NS(id)
  div(
    radioButtons(ns("vertaus"),"Verrattuna muihin, miten arvioisit riskinottohalukkuutesi?",
                 choices = list("Alempi" = 1, "Keskimääräinen" = 2,
                                "Korkeampi" = 3)),

    radioButtons(ns("Value"), "Kuinka paljon sijoituksen arvo saa laskea, ennen kuin se tuntuu mielestäsi erittäin epämiellyttävältä?",
                 choices = list("Ei enempää kuin 10%" = 1, "10-25%" = 2,
                                "25-50%" = 3, "Enemmän kuin 50%"=4)),

    radioButtons(ns("Savings"), "Mihin säästät tänä päivänä?",
                 choices = list("Pankkitilille" = 1, "Korkorahastoihin" = 2,
                                "Yhdistelmärahastoihin" = 3, "Osakkeisiin"= 4,"Johdannaisiin ja kryptoihin"=5)),

    radioButtons(ns("Monthly"), "Miten paljon säästät tällä hetkellä kuukausittain?",
                 choices = list("Vähemmän kuin 200e" = 1, "200-500e" = 2,
                                "500-100e" = 3, "Enemmän kuin 1000e"= 4)),

    radioButtons(ns("Work"), "Millainen työllisyystilanteesi on tällä hetkellä?",
                              choices = list("Kokoaikatöissä" = 1, "Osa-aikatöissä" = 2,
                                             "Projektiluontoisissa töissä" = 3, "Yrittäjä"= 4,"Etsin töitä"= 5)),

    radioButtons(ns("Target"), "Mikä on säästämisesi pääasiallinen tarkoitus/tavoite??",
                              choices = list("En tiedä" = 1, "Eläkesäästäminen" = 2,
                                             "Lapselle säästäminen" = 3, "Vaurastuminen"= 4)),

     radioButtons(ns("Period"), "Miten pitkään aiot säästää?",
                              choices = list("Vähemmän kuin vuoden" = 1, "Kaksi vuotta" = 2,
                                             "Viisi vuotta" = 3, "Yli viisi vuotta"= 4)),

     radioButtons(ns("Propability"), "Kuinka todennäköistä on, että sinun täytyy lopettaa säästäminen ennenaikaisesti?",
                               choices = list("Epätodennäköistä" = 1, "Mahdollista" = 2,
                                              "Todennäköistä" = 3)),
    actionButton(ns("btn"), "Click Here to get your risk result")


    )
}


questions <- function(input, output, session) {
  observe({
    observeEvent(input$btn, {
      values <-c(input$Target,input$Period,input$Propability,input$Work,input$Monthly,input$Savings,input$Value,input$vertaus)
      print(values)
      num_values <- as.numeric(values)
      print(sum(num_values))
    })
  })
}
