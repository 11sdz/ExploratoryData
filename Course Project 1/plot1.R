##plot1
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

png(filename = "plot1.png", height = 480 ,width = 480)

hist(house_pwr_cons$ActivePower,col="red",xlim = c(0,6),ylim=c(0,1400),
     main = "Global Active Power", xlab="Global Active Power (kW)")

dev.off()
