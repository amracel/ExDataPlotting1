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

# create histogram
hist(subConsumption$Global_active_power, col = "red", xlab = "Globacl Active Power (kilowatts)", main = "Global Active Power")

# save it to a file
dev.copy(png, "ExDataPlotting1/figure/plot1.png")