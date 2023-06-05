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

# Convert feb_2days's column Global_active_power into numbers
feb_2days$Global_active_power <- as.numeric(feb_2days$Global_active_power)

# Plot histogram
hist(feb_2days$Global_active_power, col='red', 
     xlab='Global Active Power (kilowatts)', main='Global Active Power')

# Save file
dev.copy(png, "plot1.png", height=480, width=480)
dev.off()
