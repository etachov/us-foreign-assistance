
library(dplyr) ## Data cleaning and manipulation
library(WDI) ## To access World Bank data
library(countrycode) ## To assign common country code for data merge

## I downloaded the original dataset from data.gov: http://www.foreignassistance.gov/web/Documents/Full_ForeignAssistanceData_Transaction.zip
## There's also a Foreign Assistance API http://www.foreignassistance.gov/web/Developer.aspx

fad <- read.csv("Full_ForeignAssistanceData_Transaction.csv", header = T, stringsAsFactors = F)

## use dplyr to get total amount disbursed by countries and objective name
fad_2013 <- fad %>% 
  select(FY, 
         Objective.Name, 
         Recipient.Country.Region, 
         Disbursed.Amount) %>%  
  filter(FY == 2013, 
        Disbursed.Amount != 0,
        ## in addition to countries, this data set includes money disbursed to regions or regional offices 
        ## i'm most interested in disbursement directly to countries so i'm excluding anything to a region, worldwide project, or office
        !grepl("Region|Regional|World|Global|Office", Recipient.Country.Region)) %>%
  group_by(Objective.Name, Recipient.Country.Region) %>%
  summarise(Total.Disbursed = sum(Disbursed.Amount))

fad_2013$merge.country <- countrycode(fad_2013$Recipient.Country.Region, "country.name", "iso2c", warn = T)

## Next we'll use the WBI package to download an GDP per Capita PPP (aka NY.GDP.PCAP.PP.CD) from the World Bank 

gdp <- WDI(indicator = c("NY.GDP.PCAP.PP.CD"), country = "all", start = 2013, end = 2013)
colnames(gdp)[1] <- "merge.country"


# Finally we'll add Freedom House data on the freedom of the press around the world
# Freedom House data lags one year; the 2014 report has data from calendar year 2013 so we'll use that

fh <- read.csv("Freedom House Freedom of the Press 2014.csv", header = T, stringsAsFactors = F)
fh$merge.country <- countrycode(fh$Country, "country.name", "iso2c", warn = T)

fad_2013 <- left_join(fad_2013, gdp)
fad_2013 <- left_join(fad_2013, fh)

fad_2013_fin <- fad_2013 %>%
  filter(!is.na(NY.GDP.PCAP.PP.CD) & !grepl("N/A", FH.2013)) %>%
  select(merge.country, Objective.Name, Recipient.Country.Region, Total.Disbursed, NY.GDP.PCAP.PP.CD,  FH.2013) %>%
  mutate(FH.2013 = as.numeric(FH.2013))

colnames(fad_2013_fin) <- c("country.code", "objective.name", "country","total.disbursed", "gdp.percapita.ppp", "fh.fotp")

write.csv(fad_2013_fin, "fad_2013_fin.csv", row.names = F)



