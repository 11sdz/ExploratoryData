##plot4
##Reading data
##
filename<-"household_power_consumption.txt"
house_pwr_cons<-read.table(file=filename, skip = 1, sep = ";",
                           col.names = c("DateTime", "Time", "ActivePower",
                                         "ReactivePower", "Voltage","Intensity",
                                         "Sub.Metering.1", "Sub.Metering.2",
                                         "Sub.Metering.3"), na.strings = "?",
                           colClasses = c("character", "character", "numeric",
                                          "numeric", "numeric", "numeric",
                                          "numeric", "numeric", "numeric")
)

## merging date with the time of the day
##
datetime<-paste(house_pwr_cons$DateTime,house_pwr_cons$Time)
datetime<-as.POSIXct(datetime, format = "%d/%m/%Y %H:%M:%S")
house_pwr_cons$DateTime<-datetime


##subsetting and filtering by start date to end date
start_date<-as.POSIXct("2007-02-01 00:00:00")
end_date<-as.POSIXct("2007-02-02 23:59:59")
house_pwr_cons<-select(house_pwr_cons,-Time) %>% filter(DateTime>=start_date & DateTime<=end_date)

segments<-as.POSIXct(c("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-03 00:00:00"))

png(filename = "plot4.png", height = 480 ,width = 480)

par(mfrow=c(2,2))

##plot2
plot(house_pwr_cons$DateTime,house_pwr_cons$ActivePower,xlab = "",
     ylab = "Global Active Power (kW)",main = "",type = "l",xaxt="n")
axis(1,at = segments,labels=weekdays(segments))

##plot3
plot(house_pwr_cons$DateTime,house_pwr_cons$Sub.Metering.1,xlab = "",
     ylab ="Energy sub metering",main = "",xaxt="n" ,type = "l")

lines(house_pwr_cons$DateTime,house_pwr_cons$Sub.Metering.2,col="red")
lines(house_pwr_cons$DateTime,house_pwr_cons$Sub.Metering.3,col="green")

axis(1,at = segments,labels=weekdays(segments))

legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
       col = c("black", "red", "green"), lty = 1)

##plot4
##x,y graph of how the Voltage changes throughout the day
plot(house_pwr_cons$DateTime,house_pwr_cons$Voltage,xlab = "datetime",
     ylab ="Voltage",main = "",xaxt="n" ,type = "l")
axis(1,at = segments,labels=weekdays(segments))

##plot5
##x,y graph of how the Reactive power changes throughout the day
plot(house_pwr_cons$DateTime,house_pwr_cons$ReactivePower,xlab = "datetime",
     ylab ="Reactive Power",main = "",xaxt="n" ,type = "l")
axis(1,at = segments,labels=weekdays(segments))

dev.off()