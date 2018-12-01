
#NOTES: Only one fund-id available

fetchFunds <- function(funds) {

  ################
  ### Hinnasto ###
  ################

  library(pdftools)
  loc <- funds$documents$PRICE_LIST[1]
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

  #namesEN <- funds$nameOfFund
  namesFI <- c("OP-KORKOTUOTTO",
               "OP-DELTA",
               "OP-ROHKEA",
               "OP-VAROVAINEN",
               "OP-POHJOISMAAT INDEKSI",
               "OP-EUROOPPA INDEKSI",
               "OP-AMERIKKA INDEKSI",
               "OP-AASIA INDEKSI",
               "OP-MALTILLINEN",
               "OP-MAAILMA"
  )

  temp <- funds[,c(1:2,4)]
  colnames(temp) <- c("Isin-Koodi", "Yksikköhinta", "Aikaleima")
  rows <- which(hinnasto$Rahasto %in% namesFI)
  temp <- cbind(temp, hinnasto[rows,])
  temp$Rahasto <- namesFI
  taulu <- temp

  api_info <- OPAPI_info()
  tt <- data.frame(GET(api_info, "funds/50090"))
  temp <- select(tt, id, name.fi, riskClass, expectedReturnPerAnnum)[1,]
  colnames(temp)[2] <- "Rahasto"
  temp$Rahasto <- toupper(temp$Rahasto)
  taulu <- left_join(taulu, temp, by = "Rahasto")

  taulu
}







