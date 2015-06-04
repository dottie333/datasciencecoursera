household <- read.table("household_power_consumption.txt", header = TRUE, na.string ="?",sep = ";")

housedata <- subset(household,household[1] == ("1/2/2007") | household[1]==("2/2/2007"))

housedata <- na.omit(housedata)

intv<- as.Date(housedata$Date,format="%d/%m/%Y")
atd = format(intv,format="%a")




with(housedata, plot(housedata$Global_active_power,
                     ylab ="Global Active Power (kilowatts)",xlab = " ",
                     type='l',
                     #points(atd),
                     #axis(1,at=1:3,lab=c("Thu","Fri","Sat"))
                     ))

dev.copy(png,file ="plot2.png")
dev.off()
