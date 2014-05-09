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

# plot the first graph - Gloabl Active Power histrogram
# create a png device to save the plot, 480x480 ist the default value, it's included
# here just for documentation purposes
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(e$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()