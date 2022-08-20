require(tidyverse)
install.packages('WDI')
require(WDI)
install.packages('maps')
require(maps)
install.packages('countrycode')
require(countrycode)

#install tidyverse, WDI, maps, Countrycode
require(tidyverse)
install.packages('WDI')
require(WDI)
install.packages('maps')
require(maps)
install.packages('countrycode')
require(countrycode)

# WDI
WDIsearch("gdp.*capita.*PPP") #search for dataset of GDP in WDI database
WDIsearch("CO2.*capita") #search for dataset of CO2 in WDI database
#import WDI dataset name - "NY.GDP.PCAP.PP.KD","EN.ATM.CO2E.PC"(indicator name) from WDI database for year 2010 only.
wdi_data <- WDI(indicator = c("NY.GDP.PCAP.PP.KD","EN.ATM.CO2E.PC"), start=2010, end=2010, extra=TRUE)
view(wdi_data)
wdi_data = as_tibble(wdi_data) #saving as a tibble
#Renaming the column name to GDPpercap & Emit_CO2percap
wdi_data <- wdi_data %>% rename(GDPpercap=NY.GDP.PCAP.PP.KD,Emit_CO2percap=EN.ATM.CO2E.PC)
view(wdi_data)
write_csv(wdi_data,"wdi_CO2_GDP.csv") #converting into CSV file
wdi <- read_csv("wdi_CO2_GDP.csv") #saving csv file into a variable
summary(wdi$GDPpercap)

# Map data
dat_map <- map_data("world") #retrieve data from the map
dim(dat_map) #to show the dimensions of the data
#merge
#to import world-wide standard country code in dat_map-ccode column from the destination World bank
dat_map$ccode<- countrycode(dat_map$region,origin="country.name",destination="wb")
#to import world-wide standard countrycode in wdi-ccode column from the destination World bank
wdi$ccode <- countrycode(wdi$country,origin="country.name",destination="wb")
#Merged the datasets using full joint (to include all rows in x or y) by column “ccode”
merged <- full_join(dat_map, wdi, by="ccode")
#Used ggplot and fill Emit_CO2percap to map CO2 emissions by respective countries
ggplot(merged,aes(x=long,y=lat,group=group,fill=Emit_CO2percap))+geom_polygon()
#Therefore, few countries whose country code could not import need to be removed from the map.
merged <- merged %>% drop_na(ccode)
final_map <-
  ggplot(merged,aes(x=long,y=lat,group=group,fill = log10(Emit_CO2percap)))+ geom_polygon()+
  scale_fill_gradient(low = "green", high = "red")+
  xlab("Doses(per million)")+
  ylab("Countries")+
  labs(title = "Total CO2 contribution by Countries per capita")+
  labs(subtitle = "Report as per data 2010")
  
  
#to store map into final_map

print(final_map) #print map
