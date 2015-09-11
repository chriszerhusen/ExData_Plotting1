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

## Create Plot

png(file = "plot3.png")  ## Create file for plot to be saved in

plot(newdat[,10], newdat[,7], type = "l", xlab = "", 
     ylab = "Energy sub metering")
points(newdat[,10], newdat[,8], type = "l", col = "red")
points(newdat[,10], newdat[,9], type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 1, 
       legend = names(newdat[,7:9]))

dev.off()  ## Stop R from sending plots to plot3.png file