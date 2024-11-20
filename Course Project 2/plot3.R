#plot3

################################ Question 3 #####################################
# Of the four types of sources indicated by the 
# type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
################################################################################

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore<-subset(NEI,fips=="24510")
baltimore<-select(baltimore,-c(fips,SCC,Pollutant))

balt_mean_ty<-baltimore %>% group_by(type,year) %>%
  summarize(mean_emission=mean(Emissions))

png(filename = "plot3.png",width = 480,height = 480)

g<-ggplot(data=balt_mean_ty,mapping = aes(year,mean_emission,colour=type))
g+geom_line(linewidth=1)+labs(title="Emission rate on 4 different type",x="Year",y="Emission")

dev.off()