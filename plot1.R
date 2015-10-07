household <- read.table("household_power_consumption.txt", header = TRUE, na.string ="?",sep = ";")

housedata <- subset(household,household[1] == ("1/2/2007") | household[1]==("2/2/2007"))

housedata <- na.omit(housedata)




with(housedata, hist(housedata$Global_active_power,main = "Global Active Power",
                     xlab ="Global Active Power (kilowatts)", col = "red" ))

dev.copy(png,file ="plot1.png")
dev.off()






