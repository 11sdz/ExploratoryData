#plot4

################################ Question 4 #####################################
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?
################################################################################

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_scc<-grepl("Coal",ignore.case = T,SCC$Short.Name)
coal_scc<-SCC[coal_scc,]

coal_scc<-select(coal_scc,SCC)
coal_scc<-with(coal_scc,unique(SCC))

filtered_NEI <- NEI %>% filter(SCC %in% coal_scc)

mn99<-with(subset(filtered_NEI,year=="1999"),
           mean(Emissions,na.rm=T))
mn02<-with(subset(filtered_NEI,year=="2002"),
           mean(Emissions,na.rm=T))
mn05<-with(subset(filtered_NEI,year=="2005"),
           mean(Emissions,na.rm=T))
mn08<-with(subset(filtered_NEI,year=="2008"),
           mean(Emissions,na.rm=T))

png(filename = "plot4.png",width=480,height = 480)

plot(c("1999","2002","2005","2008"),c(mn99,mn02,mn05,mn08), ## (x,y)
     pch=19,type="l", ## line graph
     main="Emission Rate (Coal combustion related)\n from 1999 to 2008\n in the USA",
     ylab = "PM2.5 Emitted (tons)",xlab="Year",xaxt="n") ## axis title and segments

axis(1,at = c("1999","2002","2005","2008")) ##x will devide by segments of 3 years from 99 to 08
points(c("1999","2002","2005","2008"),c(mn99,mn02,mn05,mn08),pch=19) ## adding points (x,y)

dev.off()