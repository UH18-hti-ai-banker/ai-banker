
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
  a<- Wealth[which(Wealth$Type == "Asset"),]
  l<-Wealth[which(Wealth$Type == "Liability"),]
  savings <- sum(as.numeric(a$Value))-sum(as.numeric(l$Value))
  Wealth[nrow(Wealth) + 1,] = list("Savings",savings,"Savings",0)
  ggplot(Wealth , aes(x=Type,y=Value, fill=Name)) +
    geom_bar(stat = "identity") +
    theme_minimal()
}
