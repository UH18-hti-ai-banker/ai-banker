library(readxl)
library(plyr)
library(ggplot2)
library(dplyr)




OP <- read_excel("data/OPpayments.xlsx")
Random <- read_excel("data/OPpayments.xlsx", sheet = 2)

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

funds <- Total_assets[which(Total_assets$subject == "Rahasto"),]

if(sum(funds$sum) > 200){
  print("TOO EXPENSIVE, click here to get your funds cheaper")
}


### Kuukausimenot

bp<- ggplot(Total_assets, aes(x="", y=sum, fill=subject))+
  geom_bar(width = 1, stat = "identity")
bp

library(ggplot2)
# Cost line plotting
View(Total_assets)

Costs <- Total_assets[which(Total_assets$payment == "Cost"),]

ggplot(Costs, aes(x = Date, y = sum)) +
  geom_line(aes(color = payment), size = 1) +
  scale_color_manual(values = c("red")) +
  theme_minimal()


## GGplot from Assets, liabilities and Savings
Wealth <- read_excel("data/OPpayments.xlsx", sheet = "Varallisuus")
a<- Wealth[which(Wealth$Type == "Asset"),]
l<-Wealth[which(Wealth$Type == "Liability"),]
savings <- sum(as.numeric(a$Value))-sum(as.numeric(l$Value))

Wealth[nrow(Wealth) + 1,] = list("Savings",savings,"Savings",0)


ggplot(Wealth , aes(x=Type,y=Value, fill=Name)) +  geom_bar(stat = "identity")


