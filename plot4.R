##Read first five rows to identify classes of the columns
tab5rows <- read.table("./data/household_power_consumption.txt", header = TRUE, sep =";", nrows = 5)
tab5rows
classes <- sapply(tab5rows, class)
classes[1:2] <- "character"

##Read all data. Now, it should be faster because of calClasses and quote
dataAll <- read.table("./data/household_power_consumption.txt", header = TRUE, sep =";", na.strings="?", comment.char = "", colClasses=classes)
##Convert Date columnt to date type
dataAll$Date <- strptime(dataAll[,1], "%e/%m/%Y")

##Subsetting data 2007/02/01 & 2007/02/02
data <- subset(dataAll, dataAll$Date == as.POSIXlt("2007-02-01") | dataAll$Date == as.POSIXlt("2007-02-02"))
str(data)

##Create new columnt with date and time
data$DateTime = paste(data$Date, data$Time)
data$DateTime = as.POSIXlt(data$DateTime,format="%Y-%m-%d %H:%M:%S")

##Set language to Eng for days of the week formatting
Sys.setlocale("LC_TIME", "English")

####Output the plots to png with width=height=480
png("./plots/plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#TopLeft plot
plot(x = data$DateTime, y = data$Global_active_power, type="l", ylab = "Global Active Power", xlab = "")
#TopRight plot (mfrow)
plot(x = data$DateTime, y = data$Voltage, type="l", ylab = "Voltage", xlab = "datetime")
#BottomLeft
plot(x = data$DateTime, y = data$Sub_metering_1, type="l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(x = data$DateTime, y = data$Sub_metering_2, col = "red")
lines(x = data$DateTime, y = data$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bg = "transparent",
       bty = "n",
       lty = c(1,1,1),
       col = c("black", "red", "blue")
)
#BottomRight
plot(x = data$DateTime, y = data$Global_reactive_power, type="l", main = "", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
