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

#Prepare File
png(filename = "./plot1.png", width = 480, height = 480, units="px")
# plot data
with(data, hist(Global_Active_Power, xlab = 'Global Active Power (KW)', main = 'Global Active Power', col = 'red'))
dev.off()