t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
head(t)
## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t$Time <- format(t$Time) #Time to char
# t$Date<-format(t$Date)

## extract 2 days- Feb. 10, 2007 to Feb. 11, 2007
t <- subset(t,Date >= as.Date("2007-2-10") & Date <= as.Date("2007-2-11"))


strDays <- format(t$Date, "%A")
strDays<-weekdays(t$Date)
table(strDays)
t<-cbind(strDays,t)
## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
t<-cbind(dateTime,t)

## convert an object to one of the two classes used to represent date/time
## format dateTime Column (this will convert to current tz location i.e. AU)
t$dateTime <- as.POSIXct(dateTime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage ", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy sub metering  ", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", ylab="Global_Rective_Power",xlab="")})

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()