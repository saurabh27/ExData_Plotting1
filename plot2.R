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

# plot the second graph - line chart of the time series
# create a png device to save the plot, 480x480 ist the default value, it's included
# here just for documentation purposes
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(e$Global_active_power, ylab="Global Active Power (kilowatts)", type="l", xaxt="n", xlab="")
# plot day of week on axis - since I don't want to deal with any locale
# issued fo the weekday abbreviation, I just use constants for this
axis(1, at=c(1,nrow(e)/2+1,nrow(e)),labels=c("Thu","Fri","Sat"))
dev.off()