library(readxl)
library(plyr)
library(ggplot2)
library(dplyr)




OP <- read_excel("data/OPpayments.xlsx")
Random <- read_excel("data/OPpayments.xlsx", sheet = "Random")

Total_assets <- rbind(OP,Random)


#Income <- subset(Total_assets, select = c())


### Jaetaan data Income, Costs, Wealth
Income <- Total_assets[which(Total_assets$payment == "Income"),]
#count(Income$subject)


Cost <- Total_assets[which(Total_assets$payment == "Cost"),]
#count(Cost$subject)

count(Total_assets, "subject")
unique(Total_assets$subject)


### Count monthly payments, freqcuency and average

totals_table <-  Total_assets %>%
                      group_by(Month,payment,subject) %>%
                      summarise(sum = sum(sum))

###### IF-lause

funds <- Total_assets[which(Total_assets$subject == "FUND"),]
funds$sum

if(funds$sum > 200){
  print("TOO EXPENSIVE, click here to get your funds cheaper")
}


### Kuukausimenot

bp<- ggplot(Total_assets, aes(x="", y=sum, fill=subject))+
  geom_bar(width = 1, stat = "identity")
bp



