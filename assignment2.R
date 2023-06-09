getmonitor <- function(id, directory, summarize = FALSE) {
        ## 'id' is a vector of length 1 indicating the monitor ID
        ## number. The user can specify 'id' as either an integer, a
        ## character, or a numeric.
         
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'summarize' is a logical indicating whether a summary of
        ## the data should be printed to the console; the default is
        ## FALSE
        
        ## Your code here

  idStr <- if(class(id) == "character") id else sprintf("%03d", id)

  df <- read.csv(paste0(directory,"/",idStr,".csv"))
  if(summarize){
    print(summary(df))
  }

  df
}

pol001 <- getmonitor(1.0, "compdata/week2/specdata", TRUE)
pol002 <- getmonitor(2, "compdata/week2/specdata", TRUE)
pol003 <- getmonitor("003", "compdata/week2/specdata", TRUE)

setwd("compdata/week2")
data <- getmonitor(1, "specdata")
head(data)

data <- getmonitor(101, "specdata", TRUE)
head(data)

data <- getmonitor("200", "specdata", TRUE)

complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

  headers <- c("id", "nobs")
  rows <- c()
  for(i in 1:length(id)){
    m <- getmonitor(id[i], directory)
    rows[i] <- nrow(subset(m,!is.na(sulfate) & !is.na(nitrate)))
  }

  data.frame(id = id, nobs = rows)
}

complete("specdata", 1) 
complete("specdata", c(2, 4, 8, 10, 12)) 
complete("specdata", 30:25) 
complete("specdata", 3) 

corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations

  comp <- complete("specdata") 
  valid <- subset(comp, nobs > threshold)

  corrVector <- c()
  if(nrow(valid) > 0){
    for(i in 1:length(valid$id)){
      m <- getmonitor(valid$id[i], directory)
      validObs <- subset(m, !is.na(sulfate) & !is.na(nitrate))  
      corrVector[i] <- cor(validObs$sulfate, validObs$nitrate)
    }
    corrVector
  }else{
    numeric(0)
  }
}

cr <- corr("specdata", 150) 
head(cr)
summary(cr)

cr <- corr("specdata", 400) 
head(cr)
summary(cr)

cr <- corr("specdata", 5000) 
summary(cr) 
length(cr) 

cr <- corr("specdata") 
summary(cr) 
length(cr)