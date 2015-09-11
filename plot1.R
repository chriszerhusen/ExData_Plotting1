## Read in the Data.  Since rows are being skipped when reading in the data, I first
## extract the column names from the file.

library(dplyr)

cols <- read.table("household_power_consumption.txt", sep = ";", 
                   stringsAsFactors = FALSE, nrows = 1)

colvect <- as.vector(cols)

dat <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                      na.strings = "?", col.names = colvect, stringsAsFactors = FALSE 
                      , skip = 66636, nrows = 2880) ## reads only the desired entries

newdat <- mutate(dat, Whole_Time = paste(Date, Time))
newdat$Whole_Time <- strptime(newdat$Whole_Time, format = "%d/%m/%Y %H:%M:%S")



## Create Histogram

png(file = "plot1.png")  ## Create file for histogram to be saved in

hist(data[,3], col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.off()  ## Stop R from sending plots to plot1.png file
