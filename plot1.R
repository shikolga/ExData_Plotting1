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
# convert Date and Time to POSIXct format and create a weekday column
subdata$DateTime <- strptime(subdata$DateTime,"%d/%m/%Y %H:%M:%S")
subdata <- mutate(subdata, Weekday = weekdays(subdata$DateTime, abbreviate = TRUE))
#draw a histogram and copy to png
with(subdata, hist(subdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")) 
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off()