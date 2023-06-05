# Download data
fileName <- "household_power_consumption"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(fileName)){
  download.file(fileURL, fileName)
  unzip(fileName)
}


# Reading data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   stringsAsFactors=FALSE)


# Convert data's column Date into date-type 
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subset first 2 days of Feb 2007
feb_2days <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Make DateTime column (character class)
DateTime <- paste(as.character(feb_2days$Date), feb_2days$Time)
# Convert DateTime column in to time class
DateTime <- as.POSIXct(DateTime)
# Append DateTime column to feb dataset
feb_2days <- cbind(DateTime, feb_2days)

# Convert feb_2days's column Global_active_power into numbers
feb_2days$Global_active_power <- as.numeric(feb_2days$Global_active_power)
# Convert feb_2days's column Sub_metering_1 through 3 into numbers
feb_2days$Sub_metering_1 <- as.numeric(feb_2days$Sub_metering_1)
feb_2days$Sub_metering_2 <- as.numeric(feb_2days$Sub_metering_2)
feb_2days$Sub_metering_3 <- as.numeric(feb_2days$Sub_metering_3)
# Convert feb_2days's column Voltage into numbers 
feb_2days$Voltage <- as.numeric(feb_2days$Voltage)
# Convert feb_2days's column Global_reactive_power into numbers
feb_2days$Global_reactive_power <- as.numeric(feb_2days$Global_reactive_power)

# Plot 
par(mfrow=c(2,2))
with(feb_2days, {
  # first plot
  plot(Global_active_power~DateTime, type='l', xlab="", ylab='Global Active Power')
  # second plot
  plot(Voltage~DateTime, type='l', ylab='Voltage')
  
  # third plot
  plot(Sub_metering_1~DateTime, type='l', xlab="", ylab='Energy sub metering')
  lines(Sub_metering_2~DateTime, col='red')
  lines(Sub_metering_3~DateTime, col='blue')
  legend("topright", col=c('black','red','blue'),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n", lty=1)
  # fourth plot
  plot(Global_reactive_power~DateTime, type='l')
  
  })


# Save file
dev.copy(png, "plot4.png", height=480, width=480)
dev.off()