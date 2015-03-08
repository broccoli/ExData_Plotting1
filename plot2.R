

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


## create plot in png
png(filename="plot2.png")
plot(datasub$datetime, datasub$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(datasub$datetime, datasub$Global_active_power)
dev.off()



