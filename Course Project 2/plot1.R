##plot1
################################ Question 1 #####################################
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
##Using the base plotting system, make a plot showing the total PM2.5 emission
##from all sources for each of the years 1999, 2002, 2005, and 2008.
################################################################################

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Creating mean variables for each year
mn99<-with(subset(NEI,year==1999), ##creating a subset that contains only data from 1999
           mean(Emissions,na.rm=TRUE)) ## calculating mean value for that year
mn02<-with(subset(NEI,year==2002),
           mean(Emissions,na.rm=TRUE))
mn05<-with(subset(NEI,year==2005),
           mean(Emissions,na.rm=TRUE))
mn08<-with(subset(NEI,year==2008),
           mean(Emissions,na.rm=TRUE))


png(filename = "plot1.png",height=480,width=480)## creating png file for the plot

plot(c("1999","2002","2005","2008"),c(mn99,mn02,mn05,mn08), ## (x,y)
     pch=19,type="l", ## line graph
     main="Emission Rate from 1999 to 2008 in the USA",
     ylab = "PM2.5 Emitted (tons)",xlab="",xaxt="n") ## axis title and segments

axis(1,at = c("1999","2002","2005","2008")) ##x will devide by segments of 3 years from 99 to 08
points(c("1999","2002","2005","2008"),c(mn99,mn02,mn05,mn08),pch=19) ## adding points (x,y)

dev.off() 