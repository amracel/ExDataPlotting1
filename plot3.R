# Read in a sample of the dataset and figure out the column types
sample <- read.delim("household_power_consumption.txt", sep =";", header = TRUE, nrows = 5)

# Get the class types for each column
classes <- sapply(sample, class)

# Read in the dataset with the 'right' column types
consumption <- read.delim("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = classes, na.string = "?")

# Convert Date and time to strings and 'paste' them into a single column
consumption$Date <- as.character(consumption$Date)
consumption$Time <- as.character(consumption$Time)
consumption$DateTime <- paste(consumption$Date, consumption$Time)

# convert new column to date object, then subset the dataset based on the values in that
# date object

consumption$DateTime <- strptime(consumption$DateTime, format = "%d/%m/%Y %H:%M:%S")
subConsumption <- consumption[which(consumption$DateTime >= "2007-02-01 00:00:00" & consumption$DateTime <= "2007-02-02 23:59:59"),]

# Open file
dev.copy(png, "ExDataPlotting1/figure/plot3.png")

# Add plotting points/lines
with(subConsumption, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
lines(subConsumption$DateTime, subConsumption$Sub_metering_1)
lines(subConsumption$DateTime, subConsumption$Sub_metering_2, col = "red")
lines(subConsumption$DateTime, subConsumption$Sub_metering_3, col = "blue")

# Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), lty = 1)

# close file
dev.off()