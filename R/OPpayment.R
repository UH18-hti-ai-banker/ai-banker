library("RColorBrewer")

getTotal_assets <- function() {
  op_sheet <- read_excel("data/OPpayments.xlsx")
  nordea_sheet <- read_excel("data/OPpayments.xlsx", sheet = 2)
  rbind(op_sheet,nordea_sheet)
}

# Cost line plotting

getCostsPlot <- function() {
  total = getTotal_assets()
  Expenditure <- total[which(total$payment == "Expenditure"),]
  ggplot(Expenditure, aes(x = Date, y = sum)) +
    geom_line(aes(color = payment), size = 1) +
    scale_color_manual(values = c("red")) +
    theme_minimal()
}

getWealthPlot <- function() {
  Wealth <- read_excel("data/OPpayments.xlsx", sheet = "Varallisuus")
  Wealth[which(Wealth$Type == "Asset"), "Type"] <- "Varat"
  Wealth[which(Wealth$Type == "Liability"), "Type"] <- "Velat"
  a<- Wealth[which(Wealth$Type == "Varat"),]
  l<-Wealth[which(Wealth$Type == "Velat"),]
  savings <- sum(as.numeric(a$Value))-sum(as.numeric(l$Value))
  Wealth[nrow(Wealth) + 1,] = list("Säästöt",savings,"Säästöt",0)
  ggplot(Wealth , aes(x=Type,y=Value, fill=Name)) +
    geom_bar(stat = "identity") +
    theme_minimal() +
    theme(axis.text.y = element_text(angle=45, size = 9, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("€") +
    scale_fill_brewer(palette="RdBu")
}
