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

##creating Plot4
png (filename = "plot4.png", width=480, height=480, units="px") 
par(mfcol = c(2,2))
with(subData, {
    plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
    plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
    lines(DateTime, Sub_metering_1, type = "l")
    lines(DateTime, Sub_metering_2, type = "l", col = "red")
    lines(DateTime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), bty = "n")
    plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage",  type = "l")
    plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
})
dev.off()

