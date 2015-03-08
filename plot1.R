

## read in data
if (!exists("data")) {
	print("reading data...")
	data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")	
	print("done reading data.")
}

## get subset of data for 1/2/2007 - 2/2/2007
datasub <- data[data$Date %in% c("1/2/2007", "2/2/2007") , ]

## add column of datetime
datasub <- transform(datasub, datetime = paste(Date, Time))
datasub$datetime <- strptime(datasub$datetime, format = "%d/%m/%Y %H:%M:%S")

## convert column to numeric
datasub$Global_active_power <- as.numeric(as.character(datasub$Global_active_power))



## create histogram as png
png(filename="plot1.png")
hist(datasub$Global_active_power, main="Global Active Power", col="red", xlab="")
title(xlab = "Global Active Power(kilowatts)")
dev.off()



