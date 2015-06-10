NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

NEI <- na.omit(NEI)

NEI[order(NEI$year,NEI$type),]

#Subset for Baltimore City
BAL <- subset(NEI,NEI$fips == "24510")


p1 <- subset(BAL, BAL$type == "POINT")
p2 <- subset(BAL, BAL$type == "NONPOINT")
p3 <- subset(BAL, BAL$type == "ON-ROAD")
p4 <- subset(BAL, BAL$type == "NON-ROAD")


par(mfrow = c(2,2))
par(mar= c(5.1,4.1,1.5,0.75))


with(p1, plot(p1$year,p1$Emissions, xlab = "", ylab = "Emissions",pch = 20)) 
title(main = "POINT Emissions")

with(p2, plot(p2$year,p2$Emissions, xlab = "", ylab = "Emissions", pch =20)) 
title(main = "NONPOINT Emissions")

with(p3, plot(p3$year,p3$Emissions, xlab = "", ylab = "Emissions", pch =20)) 
title(main = "ON-ROAD Emissions")

with(p4, plot(p4$year,p4$Emissions, xlab = "", ylab = "Emissions", pch =20)) 
title(main = "NON-ROAD Emissions")

dev.copy(png,file ="plot2.png",width = 480,height = 480)
dev.off()