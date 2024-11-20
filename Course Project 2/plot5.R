#plot5

################################ Question 5 #####################################
# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?
################################################################################

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore_NEI<-subset(NEI,fips=="24510")
baltimore_SCC<- SCC %>% filter(SCC %in% baltimore_NEI$SCC)

temp<-grepl("motor|vehicle",baltimore_SCC$Short.Name,ignore.case = T)

motor_vehicle_scc<-baltimore_SCC[temp,]$SCC

filtered_baltimore_NEI <- baltimore_NEI %>% filter(SCC %in% motor_vehicle_scc)

mn99<-with(subset(filtered_baltimore_NEI,year=="1999"),
           mean(Emissions,na.rm=T))
mn02<-with(subset(filtered_baltimore_NEI,year=="2002"),
           mean(Emissions,na.rm=T))
mn05<-with(subset(filtered_baltimore_NEI,year=="2005"),
           mean(Emissions,na.rm=T))
mn08<-with(subset(filtered_baltimore_NEI,year=="2008"),
           mean(Emissions,na.rm=T))

png(filename = "plot5.png",width=480,height = 480)

plot(c("1999","2002","2005","2008"),c(mn99,mn02,mn05,mn08), ## (x,y)
     pch=19,type="l", ## line graph
     main="Emission Rate (Motor Vehicle)\n from 1999 to 2008\n in Baltimore City",
     ylab = "PM2.5 Emitted (tons)",xlab="Year",xaxt="n") ## axis title and segments

axis(1,at = c("1999","2002","2005","2008")) ##x will devide by segments of 3 years from 99 to 08
points(c("1999","2002","2005","2008"),c(mn99,mn02,mn05,mn08),pch=19) ## adding points (x,y)

dev.off()