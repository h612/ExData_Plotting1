t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
head(t)
## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t$Time <- format(t$Time) #Time to char
# t$Date<-format(t$Date)

## extract 2 days- Feb. 10, 2007 to Feb. 11, 2007
t <- subset(t,Date >= as.Date("2007-2-10") & Date <= as.Date("2007-2-11"))

strDays <- format(t$Date, "%A")
table(strDays)
#Insert Days column
t<-cbind(strDays,t)
## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
t<-cbind(dateTime,t)

## Format dateTime Column
t$dateTime <- as.POSIXct(dateTime)

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#  Sat, sun, mon
#Draw a Linear plot
plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()