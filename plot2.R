##Check to see if the directory exists and if doesn't create it
if(!file.exists("./epcdata")){
    dir.create("./epcdata")
}

##Check to see if the file exists and if doesn't downoload and extract it.
if(!file.exists("./epcdata/household_power_consumption.txt")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile="./epcdata/ElectricPowerConsumption.zip")
    unzip("./epcdata/ElectricPowerConsumption.zip", exdir="epcdata")
}

elData <- read.table("./epcdata/household_power_consumption.txt", sep= ";" ,stringsAsFactors = FALSE, na.strings = "?", head=TRUE)


##Combine Date and Time in a new DateTime variable 
library(dplyr)
elData <- mutate(elData, DateTime = paste(Date,Time))

##Convert Date and DateTime from characters to Date, Date&Time format
elData$Date <- as.Date(elData$Date, format = "%d/%m/%Y")
elData$DateTime <- strptime(elData$DateTime, "%d/%m/%Y %H:%M:%S")

##Subset the records from "2007-02-01" and "2007-02-02"
subData <- subset(elData, elData$Date >= "2007-02-01" & elData$Date <= "2007-02-02")


library(datasets)

##creating Plot2
png(filename = "plot2.png", width=480, height=480, units="px") 
plot(subData$DateTime, subData$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()

