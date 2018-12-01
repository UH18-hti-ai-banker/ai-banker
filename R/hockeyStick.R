
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

###########

hockeyStick <- function(specs) {

  #Timeline
  startdate <- as.Date("2019-01-01", format = "%Y-%m-%d")
  timeline <- seq.Date(startdate-1, as.Date("2029-12-31", format = "%Y-%m-%d"), by = "month")
  bigtemp <- data.frame(matrix(NA, ncol = length(specs$Alku) + 1, nrow = length(timeline)), stringsAsFactors = F)
  colnames(bigtemp) <- c("PVM", names(specs$Alku))
  bigtemp$PVM <- timeline
  bigtemp[1,-1] <- specs$Alku

  income <- specs$Virrat["Palkka"]
  expenditure <- specs$Virrat["Menot"]
  loan <- specs$Virrat["Lainalyhennys"]
  invest <- income - expenditure - loan

  #Sim (Investing)
  bigtempOriginal <- bigtemp
  for(i in 2:nrow(bigtemp)) {
    bigtemp[i,-1] <- bigtemp[(i-1),-1]*(100+(1/12)*specs$Korko)/100
    bigtemp[i,"Tili"] <- bigtemp[(i),"Tili"] + income - expenditure - loan - invest
    bigtemp[i,"Rahasto"] <- bigtemp[(i),"Rahasto"] + invest
    bigtemp[i,"Asuntolaina"] <- bigtemp[(i),"Asuntolaina"] - loan
    if(bigtemp[i,"Asuntolaina"] < 0) {
      invest <- invest + loan
      loan <- 0
      bigtemp[i,"Tili"] <- bigtemp[i,"Tili"] + abs(bigtemp[i,"Asuntolaina"])
      bigtemp[i,"Asuntolaina"] <- 0
    }
  }
  bigtemp <- mutate(bigtemp, Nettovarallisuus = Tili + Asunto + Rahasto - Asuntolaina)
  hockeyStick <- ts(bigtemp$Nettovarallisuus, start = c(2018,12), frequency = 12)

  #Sim (Not Investing)
  bigtemp <- bigtempOriginal
  for(i in 2:nrow(bigtemp)) {
    bigtemp[i,-1] <- bigtemp[(i-1),-1]*(100+(1/12)*specs$Korko)/100
    bigtemp[i,"Tili"] <- bigtemp[(i),"Tili"] + income - expenditure - loan
    bigtemp[i,"Rahasto"] <- bigtemp[(i),"Rahasto"]
    bigtemp[i,"Asuntolaina"] <- bigtemp[(i),"Asuntolaina"] - loan
    if(bigtemp[i,"Asuntolaina"] < 0) {
      invest <- invest + loan
      loan <- 0
      bigtemp[i,"Tili"] <- bigtemp[i,"Tili"] + abs(bigtemp[i,"Asuntolaina"])
      bigtemp[i,"Asuntolaina"] <- 0
    }
  }
  bigtemp <- mutate(bigtemp, Nettovarallisuus = Tili + Asunto + Rahasto - Asuntolaina)
  uncleScrooge <- ts(bigtemp$Nettovarallisuus, start = c(2018,12), frequency = 12)

  #Sim (Spending)
  bigtemp <- bigtempOriginal
  for(i in 2:nrow(bigtemp)) {
    bigtemp[i,-1] <- bigtemp[(i-1),-1]*(100+(1/12)*specs$Korko)/100
    bigtemp[i,"Tili"] <- bigtemp[(i),"Tili"] + income - expenditure - loan - invest
    bigtemp[i,"Rahasto"] <- bigtemp[(i),"Rahasto"]
    bigtemp[i,"Asuntolaina"] <- bigtemp[(i),"Asuntolaina"] - loan
    if(bigtemp[i,"Asuntolaina"] < 0) {
      invest <- invest + loan
      loan <- 0
      bigtemp[i,"Tili"] <- bigtemp[i,"Tili"] + abs(bigtemp[i,"Asuntolaina"])
      bigtemp[i,"Asuntolaina"] <- 0
    }
  }
  bigtemp <- mutate(bigtemp, Nettovarallisuus = Tili + Asunto + Rahasto - Asuntolaina)
  Yolo <- ts(bigtemp$Nettovarallisuus, start = c(2018,12), frequency = 12)

  toRet <- data.frame(cbind(as.character(bigtemp$PVM),
                   hockeyStick - Yolo,
                   uncleScrooge - Yolo),
             stringsAsFactors = F)
  colnames(toRet) <- c("Date", "Invest", "Keep")
  toRet$Invest <- as.numeric(toRet$Invest)
  toRet$Keep <- as.numeric(toRet$Keep)

  toRet
}


