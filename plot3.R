##load Libraries
library(ggplot2)
library(dplyr)


# If ref-folder doesnt exist, it must be created (a working directory must be selected first form R editor)
if (!file.exists("./ficheros")) {
        dir.create("./ficheros")
}


#Init variables
origen <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destino <- "./ficheros/ficheros.zip"
fileSource <- "./ficheros/household_power_consumption.txt"

#Unzip file downloaded
if (!file.exists(destino )) {
        download.file(origen , destino , method = "curl")
        unzip(destino , overwrite = T, exdir = "./ficheros")
}

#Read data only of the two days associated
data <- read.table(text = grep("^[1,2]/2/2007",readLines(fileSource),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_Intensity", "Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), na.strings = "?")

# format date and time in one
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))

#Prepare File
png(filename = "./plot3.png", width = 480, height = 480, units="px")

#Plot the data
plot(data$DateTime, data$Sub_Metering_1, xlab = "", ylab = 'En. sub metering', type = "l")
lines(data$DateTime, data$Sub_Metering_2, col = "red")
lines(data$DateTime, data$Sub_Metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), lwd = 1)

dev.off()

