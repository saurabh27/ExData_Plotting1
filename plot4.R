# read in the complete dataset, would be better to filter first on
# the date field (e.g. using the grep program) but this will not 
# work in Windows

# read the file assuming it is in the current working directory
e = read.table("household_power_consumption.txt", header = T, sep=";", na.strings="?")

# now we select on the two days that we want to chart
# note that there are no leading zeroes in the day and months fields
e = e[e$Date == "1/2/2007" | e$Date == "2/2/2007",]

# now convert the first two columns from text to a Date/Time object using the format dd/mm/yyyy HH:MM:SS
e$Date = strptime(paste(e$Date, e$Time), "%d/%m/%Y %H:%M:%S")

# the fourth plot is a 2x2 pane plot
# create a png device to save the plot, 480x480 ist the default value, it's included
# here just for documentation purposes
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
# top left chart, the same as chart #2
plot(e$Global_active_power, ylab="Global Active Power", type="l", xaxt="n", xlab="")
# plot day of week on axis - since I don't want to deal with any locale
# issued fo the weekday abbreviation, I just use constants for this
axis(1, at=c(1,nrow(e)/2+1,nrow(e)),labels=c("Thu","Fri","Sat"))
# top right chart
plot(e$Voltage, ylab="Voltage", type="l", xaxt="n", xlab="datetime")
# plot day of week on axis - since I don't want to deal with any locale
# issued fo the weekday abbreviation, I just use constants for this
axis(1, at=c(1,nrow(e)/2+1,nrow(e)),labels=c("Thu","Fri","Sat"))

# bottom left chart, the same as chart #3
plot(e$Sub_metering_1, ylab="Energy sub metering", type="l", xaxt="n", col="black", xlab="")
lines (e$Sub_metering_2, col="red")
lines (e$Sub_metering_3, col="blue")
# there's no box around the legend in this version of the graph
legend("topright", col=c("black", "red", "blue"), lwd=1, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# plot day of week on axis - since I don't want to deal with any locale
# issued fo the weekday abbreviation, I just use constants for this
axis(1, at=c(1,nrow(e)/2+1,nrow(e)),labels=c("Thu","Fri","Sat"))

# bottom right chart
plot(e$Global_reactive_power, ylab="Global_reactive_power", type="l", xaxt="n", xlab="datetime")
# plot day of week on axis - since I don't want to deal with any locale
# issued fo the weekday abbreviation, I just use constants for this
axis(1, at=c(1,nrow(e)/2+1,nrow(e)),labels=c("Thu","Fri","Sat"))
dev.off()