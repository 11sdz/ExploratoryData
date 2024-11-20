#plot6

################################ Question 6 #####################################
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California(fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?
################################################################################

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cali_balti_NEI<-subset(NEI,fips=="06037" | fips=="24510")
cali<-subset(NEI,fips=="06037")

temp<-grepl("motor|vehicle",SCC$Short.Name,ignore.case = T)
motor_vehicle_SCC<-SCC[temp,]

filtered_cali_balti<- cali_balti_NEI %>% filter(SCC %in% motor_vehicle_SCC$SCC)
filtered_cali_balti<- select(filtered_cali_balti,-c(Pollutant,type))

filtered_cali_balti<-filtered_cali_balti %>% group_by(fips,year) %>% 
  summarize(mean_emission=mean(Emissions,na.rm=TRUE))

filtered_cali_balti$fips[1:4]<-"Los Angeles"
filtered_cali_balti$fips[5:8]<-"Baltimore"

par(mfrow=c(1,2))

png(filename = "plot6.png",height = 480,width = 480)

barplot(filtered_cali_balti[1:4,]$mean_emission,names.arg=filtered_cali_balti[1:4,]$year
        ,main = "Los Angeles\n Emission rate \nfrom Motor Vehicle",col = "red",
        ylab = "Mean Emission",xlab = "year",ylim = c(0,70),cex.main=0.8)

barplot(filtered_cali_balti[5:8,]$mean_emission,names.arg=filtered_cali_balti[5:8,]$year
        ,main = "Baltimore City\n Emission rate \nfrom Motor Vehicle",col="blue",
        ylab = "Mean Emission",xlab = "year",cex.main=0.8)

dev.off()