#Code below reads in electric power consumption data from the file 
# "household_power_consumption.txt", then makes a histogram of global minute-
# averaged active power (in kilowatt) over a 2-day period in February, 2007.

library(data.table)


#read in the data (using absolute file location references)

filePath <- "C:\\Users\\Casey\\Documents\\ORSA STUFF\\ANALYSIS TOOLS\\Data Analysis\\Johns Hopkins Data Science Specialty\\Exploratory_Data_analysi\\Assignment1\\household_power_consumption.txt"
data <- fread(filePath, na.strings = c("?", "NA"), colClasses = c("Date", "character", 
                "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
head(data) #Take a look at the top of the data 

#Subset to data from the dates 2007-02-01 to 2007-02-02.
data2 <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

#Open a png device and create the png file to send the plot to

png(file = "plot1.png")

# Create histogram plot

hist(data2$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

#Close the png device

dev.off()






