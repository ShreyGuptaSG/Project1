##Install Packages
install.packages('lubridate')
install.packages('tidyverse')
install.packages('ggplot2')
library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
library(tibble)

##Creating table with columns Countries and Doses

Countries <- c("United States", "China" ,"India" ,"United Kindom", "Brazil", "Germany","Turkey",
              "France","Australia")
Doses <- c(213.39,195.02,127.13,43.46,33.81,22.94,20.28,17.45,1.65)
Covid <- data.frame(Countries, Doses)
print(Covid)

## Creating GGplot for visualisation

ggplot(Covid, aes(Doses, reorder(Countries, Doses), fill = Doses, label = Doses)) +
  geom_bar(stat="identity") +
  geom_text(aes(x = 150, y = Countries), vjust = 0, hjust = 0, nudge_x = 50, color = "red") +
  xlab("Doses(per million)") +
  ylab("Countries") +
  labs(title = "COVID VACCINATION 2021") +
  labs(subtitle = "COVID-19 vaccine doses administered, April 20, 2021")

