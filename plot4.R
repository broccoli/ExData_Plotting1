

## read in data
if (!exists("mydata")) {
	classes = rep("numeric", 9)
	classes[1:2] = "character"
	print("reading data...")
	mydata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=classes,
	na.strings = c("?"))
	print("done reading data.")
}

## get subset of data for 1/2/2007 - 2/2/2007
datasub <- mydata[mydata$Date %in% c("1/2/2007", "2/2/2007") , ]

## add column of datetime
datasub <- transform(datasub, datetime = paste(Date, Time))
datasub$datetime <- strptime(datasub$datetime, format = "%d/%m/%Y %H:%M:%S")


##### create plot in png
png(filename="plot4.png")
par(mfrow = c(2, 2))

## upper left plot
plot(datasub$datetime, datasub$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(datasub$datetime, datasub$Global_active_power)


## upper right plot
with(datasub, {
	plot(datetime, Voltage, type="n")
	lines(datetime, Voltage)
})

## lower left plot
plot(datasub$datetime, datasub$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(datasub$datetime, datasub$Sub_metering_1)
lines(datasub$datetime, datasub$Sub_metering_2, col="red")
lines(datasub$datetime, datasub$Sub_metering_3, col="blue")
legend("topright", lty = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## lower right plot
with(datasub, {
	plot(datetime, Global_reactive_power, type="n")
	lines(datetime, Global_reactive_power)
})

dev.off()



