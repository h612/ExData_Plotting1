t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
head(t)
## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t$Time <- format(t$Time) #Time to char

## extract 2 days- Feb. 10, 2007 to Feb. 11, 2007
t <- subset(t,Date >= as.Date("2007-2-10") & Date <= as.Date("2007-2-11"))
## Create the histogram
hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()


