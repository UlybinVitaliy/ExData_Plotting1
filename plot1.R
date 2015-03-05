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

##Output to png the Global Active Power histogram plot with width=height=480
png("./plots/plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", ylim = c(0,1200))
dev.off()
