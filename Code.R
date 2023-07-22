#Import
Swift.Codes <- read.csv("E:/Self-Learning/Data Analytics/R Program/Practice/Preppin Data/day 02/Swift Codes.csv")
View(Swift.Codes)
Transactions <- read.csv("E:/Self-Learning/Data Analytics/R Program/Practice/Preppin Data/day 02/Transactions.csv")
View(Transactions)

#Task 1: In the Transactions table, there is a Sort Code field which contains dashes. 
#We need to remove these so just have a 6 digit string

install.packages("stringr")
library("stringr")  
Transactions$sortcode <- str_remove_all(Transactions$Sort.Code,"-")

#task 2: Use the SWIFT Bank Code lookup table to bring in additional information about 
#the SWIFT code and Check Digits of the receiving bank account 
library(dplyr)
Transactions <- inner_join(Transactions, Swift.Codes, by="Bank")

#Task 3: Add a field for the Country Code 
Transactions$Country.code <- "GB"

#Tash 4: Create the IBAN as above
library(tidyr)
output_t4 <- Transactions%>%unite(IBAN, 
            Country.code, Check.Digits, SWIFT.code, sortcode, sep = "")    
Transactions <- cbind(Transactions, output_t4[5])
Transactions = Transactions [,c(1, 9)]