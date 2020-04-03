# COVID-19, testing and counts 


#libraries 
install.packages("dplyr")
library(dplyr)
install.packages("reshape2")
library(reshape2)


#Data from the COVID tracking project 
statecount <- read.csv("https://query.data.world/s/hckqcthedvuoa7apfw7p75wbazrngy", header=TRUE, stringsAsFactors=FALSE);
statepop <-read.csv(file.choose(), header = TRUE)

#####cleaning up state population data#########
#removing unused and empty rows and columns 
population <- statepop[9:61, c(1,13)] 
population <- population[-52, ]


population <- data.frame(population)
index <- as.vector(1:52)

popest <- data.frame(index, population$table.with.row.headers.in.column.A.and.column.headers.in.rows.3.through.4...leading.dots.indicate.sub.parts., population$X.11)
xname <- "index"
yname <- "state"
zname <- "pop19"
names(popest) <- c(xname, yname, zname)
popest
popestcheck <- data.frame(statecount[1:52, 1], popest$state) # out of order!

#putting state in alphabetical order
popest <- arrange(popest, state)
#this will not work because statecount is abbreviated and popest is not. So...

popabb <- read.csv(file.choose(), header = FALSE)
popabb <- popabb[ , -c(1:2)]
popabb <- arrange(popabb, V3)



#####cleaning up state count data######
statecount <- data.frame(statecount[-c(53:56), ])

statecount <- data.frame(statecount$state, statecount$positive, statecount$negative, statecount$totalTestResults,
                         statecount$hospitalized, statecount$death)

state <- "state"; pos <- "positive"; neg <- "negative"; total <- "total"; hosp <- "hospitalized"; death <- "death";


names(statecount) <- c(state, pos, neg, total, hosp, death)

statecount <- arrange(statecount, state)  

comb <- bind_cols(statecount, popabb) 
#there are 2 MAs in popabb so everything is out of order. 
  
  
  
  
  
  
  
  