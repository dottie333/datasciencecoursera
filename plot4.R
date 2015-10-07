household <- read.table("household_power_consumption.txt", header = TRUE, na.string ="?",sep = ";")

housedata <- subset(household,household[1] == ("1/2/2007") | household[1]==("2/2/2007"))

housedata <- na.omit(housedata)


dateTime   <- as.POSIXlt(paste(as.Date(housedata$Date, format="%d/%m/%Y"), housedata$Time, sep=" "))

par(mfrow = c(2,2))
par(mar= c(5.1,4.1,0.5,0.75))

plot(dateTime, housedata$Global_active_power,ylab ="Global Active Power",xlab = " ",
     type='l')
plot(dateTime, housedata$Voltage,ylab ="Voltage",xlab = "datetime ",type='l')
with(housedata, plot(dateTime,housedata$Sub_metering_1,type ="n", 
                     ylab="Energy sub metering", xlab = ""))
with(housedata,lines(dateTime,housedata$Sub_metering_1,col="black"))                                 
with(housedata,lines(dateTime,housedata$Sub_metering_2,col="red"))
with(housedata,lines(dateTime,housedata$Sub_metering_3,col="blue"))

legend("topright", pch = "__", col= c("black","red","blue"),cex = 0.75,bty ="n",
       legend = c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"))

plot(dateTime, housedata$Global_reactive_power,ylab ="Global_reactive_power",xlab = "datetime ",
     type='l')



dev.copy(png,file ="plot4.png")
dev.off()