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

# Plot 
with(feb_2days, plot(Global_active_power~DateTime, type='l', ylab='Global Active Power (kilowatts)'))

# Save file
dev.copy(png, "plot2.png", height=480, width=480)
dev.off()
