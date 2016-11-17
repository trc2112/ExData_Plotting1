#go to directory
setwd("C:\\datasciencecoursera")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip", exdir = ".")


#extract file from directory
extract <- read.table(".\\household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"))
#na.strings = "?", stringsAsFactors = FALSE,
#filter for only 02-01-2007 and 02-02-2007
filtered <- extract[extract$Date %in% c("1/2/2007", "2/2/2007"),]

#concatenate date and time into date time
final <- data.frame(strptime(paste(filtered$Date, filtered$Time), "%d/%m/%Y %H:%M"),
    filtered$Global_active_power,
    filtered$Global_reactive_power,
    filtered$Voltage,
    filtered$Sub_metering_1,
    filtered$Sub_metering_2,
    filtered$Sub_metering_3)
colnames(final)[1] <- "DateTime"
colnames(final)[2] <- "Global_active_power"
colnames(final)[3] <- "Global_reactive_power"
colnames(final)[4] <- "Voltage"
colnames(final)[5] <- "Sub_metering_1"
colnames(final)[6] <- "Sub_metering_2"
colnames(final)[7] <- "Sub_metering_3"

#create plot 3 to file
png("plot3.png", width = 480, height = 480)
par(mfrow = c(1, 1))
plot(final$DateTime, final$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(final$DateTime, final$Sub_metering_2, type = "l", col = "red")
lines(final$DateTime, final$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), cex = 0.6, lty = 1:1)
dev.off()
