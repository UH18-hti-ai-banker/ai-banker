
#NOTE: To be run only once (stratup) in the app! (slow as fetches everything)
#DEPENDS ON: opapi.R
#EXAMPLE: taulu

#Returns a table of funds, including their risk class and expected returns
fetchFunds <- function() {

  api_info <- OPAPI_info()
  api <- OPAPI()

  ################
  ### Hinnasto ###
  ################

  fundsOLD <- GET(api, "funds")

  library(pdftools)
  library(dplyr)
  loc <- fundsOLD$documents$PRICE_LIST[1]
  download.file(loc, "test.pdf")
  text <- pdf_text("test.pdf")
  splits <- strsplit(text, "\n")

  rows <- 6:95

  temp <- data.frame(matrix(NA, ncol = 8, nrow = length(rows)))
  colnames(temp) <- c("Rahasto",
                      "Merkintäpalkkio % (Konttori)",
                      "Merkintäpalkkio % (Internet)",
                      "Lunastuspalkkio % (Konttori)",
                      "Lunastuspalkkio % (Internet)",
                      "Hallinnointipalkkio P.A %",
                      "Minimisijoitus €",
                      "Jatkuva rahastosijoitus mahdollinen")
  for(i in 1:nrow(temp)) {
    t <- splits[[1]][rows[i]]
    t <- strsplit(t, "  ")[[1]]
    t <- t[which(t != "")]
    t <- t[which(t != "%")]
    temp[i,1:length(t)] <- t
  }

  #Cleaning
  #(1)
  temp <- temp[-which(nchar(temp$Rahasto) < 3),]
  #(2)
  for(i in 1:nrow(temp)) {
    name <- temp$Rahasto[i]
    n <- nchar(name)
    if(substr(name, n, n) == "*") {
      temp$Rahasto[i] <- substr(name, 1, (n-1))
      temp$`Jatkuva rahastosijoitus mahdollinen`[i] <- TRUE
    } else {
      temp$`Jatkuva rahastosijoitus mahdollinen`[i] <- FALSE
    }
  }
  #(3)
  for(j in 2:(ncol(temp)-1)) {
    for(i in 1:nrow(temp)) {
      t <- temp[i,j]
      if(length(grep("%", t)) != 0) {
        if(grep("%", t) == 1) {
          t <- sub(",", ".", t)
          temp[i,j] <- as.numeric(strsplit(t, "%")[[1]][1])
        }
      }
    }
  }
  #(4)
  for(i in 1:nrow(temp)) {
    t <- temp$`Minimisijoitus €`[i]
    if(!is.na(t)) {
      n <- nchar(t)
      if(substr(t, (n-1), n) == "**") {
        t <- substr(t, 1, (n-2))
        t <- gsub(" ", "", t)
        temp$`Minimisijoitus €`[i] <- as.numeric(t)
      }
    }
  }
  #(5)
  for(j in 4:5) {
    for(i in 1:nrow(temp)) {
      t <- temp[i,j]
      t <- sub(" ", "", t)
      if(t == "porrastettu7" | t == "porrastettu8") t <- "porrastettu"
      temp[i,j] <- t
    }
  }

  hinnasto <- temp

  ####################
  ### Rahastotaulu ###
  ####################

  funds <- data.frame(GET(api_info, "funds"))
  funds$payload.name$fi <- toupper(funds$payload.name$fi)
  funds <- data.frame(cbind(funds$payload.id, funds$payload.name$fi, funds$payload.fundType), stringsAsFactors = F)
  colnames(funds) <- c("ID", "Rahasto", "Tyyppi")
  temp <- left_join(hinnasto, funds, by = "Rahasto")
  funds <- temp[-which(is.na(temp$ID)),]
  funds$Riskiluokka <- NA
  funds$Tuotto <- NA

  for(i in 1:nrow(funds)) {
    print(paste0(i, "/", nrow(funds), "..."))
    id <- funds$ID[i]
    t <- tryCatch({
      tt <- GET(api_info, paste0("funds/",id))
      tt <- tryCatch({
        tt <- data.frame(tt, stringsAsFactors = F)[1,]
        select(tt, riskClass, expectedReturnPerAnnum)
      }, error = function(cond) {
        tt <- matrix(as.numeric(c(tt$riskClass, tt$expectedReturnPerAnnum)), byrow = T, ncol = 2)
        data.frame(tt, stringsAsFactors = F)
      })
    },error = function(cond) {
      c(NA, NA)
    })
    funds[i,(ncol(funds)-1):ncol(funds)] <- t
  }

  funds
}







