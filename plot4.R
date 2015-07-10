# download and unzip data
if (!file.exists("./ExpProject/household_power_consumption.txt")) {
    dir.create("ExpProject")
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "./ExpProject/project1.zip")
    dateaccessed <- Sys.Date()
    unzip("./ExpProject/project1.zip", exdir = "./ExpProject")
}
data <- read.csv("./ExpProject/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)
subdata <- subset(data, data$Date %in% "1/2/2007" | data$Date %in% "2/2/2007")
#merge date and time
library(dplyr)
subdata <- mutate(subdata, DateTime = paste(Date, Time, sep = " "))
# convert Date and Time to POSIXct format 
subdata$DateTime <- strptime(subdata$DateTime,"%d/%m/%Y %H:%M:%S")
#draw a plot in png
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(subdata$DateTime, subdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(subdata$DateTime, subdata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(subdata$DateTime, subdata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(subdata$DateTime, subdata$Sub_metering_2, col = "red")
lines(subdata$DateTime, subdata$Sub_metering_3, col = "blue")
legend("topright", lwd= 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(subdata$DateTime, subdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()