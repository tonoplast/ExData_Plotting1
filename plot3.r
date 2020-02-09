# Plot 1

## a placeholder for current directory (if re-running the code)
setwd(pwd)

# clear environment
rm(list=ls())


## a placeholder for current directory
pwd <- getwd()


# set working directory
setwd("./ExploratoryDataAnalysis_Assignment1")

# downloading zip file
this_file <- "household_power_consumption.zip"
this_Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(this_Url, this_file, method= 'curl')

# unzip file
unzip(this_file)

# reading data (only subsetting 1/2/2007 and 2/2/2007)
myData <- read.table(text = grep("^1/2/2007|^2/2/2007", readLines(file("household_power_consumption.txt")), value=TRUE),  
                     sep = ';', stringsAsFactors = FALSE, header = TRUE, na.strings="?",
                     col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                                   "Global_intensity", "Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# combining date and time
myData$DateTime <- as.POSIXct(paste(myData$Date, myData$Time), format="%d/%m/%Y %H:%M:%S")

# making plot 3
with(myData, {
  plot(Sub_metering_1~DateTime, type="l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2~DateTime, col="Red")
  lines(Sub_metering_3~DateTime, col="Blue")
})
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=1, lwd=2)


# save image file
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()




