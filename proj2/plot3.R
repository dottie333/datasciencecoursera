NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

NEI <- na.omit(NEI)

NEI[order(NEI$year,NEI$type),]

#Subset for Baltimore City
BAL <- subset(NEI,NEI$fips == "24510")



g <- ggplot(BAL,aes(year,Emissions)) + labs(title = "Baltimore City")

#title(main = "POINT Emissions")

p <- g + geom_point() +facet_grid(. ~ type) + geom_smooth(method = "lm")
print(p)


dev.copy(png,file ="plot3.png")
dev.off()