##Read first five rows to identify classes of the columns
unzip("./data/exdata-data-household_power_consumption.zip", files = "household_power_consumption.txt")
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep =";", nrows = 5)
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

#plot(x=(data$DateTime),y=data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

##Output the plot to png with width=height=480
png("./plots/plot2.png", width = 480, height = 480)
plot(x = (data$DateTime),y = data$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
