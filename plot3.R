t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
head(t)
## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t$Time <- format(t$Time) #Time to char

## extract 2 days- Feb. 10, 2007 to Feb. 11, 2007
t <- subset(t,Date >= as.Date("2007-2-10") & Date <= as.Date("2007-2-11"))


##---------------------------------------------

## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
t<-cbind(dateTime,t)

## Format dateTime Column
t$dateTime <- as.POSIXct(dateTime)
t$dateTime

with(t, {plot(Sub_metering_1~dateTime, type="l", ylab="ENERGY SUB METERING", xlab=" ")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')})

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
