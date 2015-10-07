household <- read.table("household_power_consumption.txt", header = TRUE, na.string ="?",sep = ";")

housedata <- subset(household,household[1] == ("1/2/2007") | household[1]==("2/2/2007"))

housedata <- na.omit(housedata)


dateTime   <- as.POSIXlt(paste(as.Date(housedata$Date, format="%d/%m/%Y"), housedata$Time, sep=" "))

plot(dateTime, housedata$Global_active_power,ylab ="Global Active Power (kilowatts)",xlab = " ",
     type='l')


dev.copy(png,file ="plot2.png")
dev.off()