household <- read.table("household_power_consumption.txt", header = TRUE, na.string ="?",sep = ";")

housedata <- subset(household,household[1] == ("1/2/2007") | household[1]==("2/2/2007"))

housedata <- na.omit(housedata)


dateTime   <- as.POSIXlt(paste(as.Date(housedata$Date, format="%d/%m/%Y"), housedata$Time, sep=" "))

#mtext ="Energy sub metering",xlab = " ", type ="n"
with(housedata, plot(dateTime,housedata$Sub_metering_1,type ="n", 
                     ylab="Energy sub metering", xlab = ""))
with(housedata,lines(dateTime,housedata$Sub_metering_1,col="black"))                                 
with(housedata,lines(dateTime,housedata$Sub_metering_2,col="red"))
with(housedata,lines(dateTime,housedata$Sub_metering_3,col="blue"))



legend("topright", pch = "__", col= c("black","red","blue"),legend = c("Sub_metering_1",
                                                                       "Sub_metering_2",
                                                                       "Sub_metering_3"))

dev.copy(png,file ="plot3.png")
dev.off()
