# U.S. Foreign Assistance by Objective and Country

I'm interested in how the theory of U.S. aid aligns with the realities on the ground. To take a closer look at this, I've pulled together a dataset that includes all bilateral U.S. foreign assistance by stated objective and recipient country for 2013 from foreignassistance.gov. To contextualize this data a bit, I've added GDP per capita from the World Bank as a measure of the recipient country's economic standing and Freedom House's press freedom score as a measure of the level of freedom of expression in the country. 

From here, I can explore questions like Does U.S. security assistance go disproportionately to country's that are trying to silence dissent? Is there a relationship between a country's economic need and the level of economic development assistance? Etc.

**Definitions**:

*country.code*: Iso2c country code to enable merging

*country*: Country name as used by the U.S. government

*objective.name*: Stated objective for aid listed the U.S. government

*total.disbursed*: Total value of aid disbursed in 2013 in 2013 U.S. dollars

*gdp.percapita.ppp*: Gross domestic product per capita using purchasing power parity in 2013 U.S. dollars

*fh.fotp*: Freedom House press freedom index score in 2013. Higher score = more suppression of freedom of speech.

**Links**:

Gist of the data: https://gist.github.com/etachov/41f90a611d61b041b1eb

Original data source: http://www.foreignassistance.gov/web/Documents/Full_ForeignAssistanceData

Code for cleaning, filtering and merging the data: https://github.com/etachov/us-foreign-assistance/blob/master/fad_2013_fin.R