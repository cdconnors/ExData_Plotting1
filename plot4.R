#Code below reads in electric power consumption data from the file 
# "household_power_consumption.txt", then makes a grid of four plots
# a line plot of global active power, a line plot of voltage, line plot of energy sub-metering
# and a line plot of global reactive power
# each on the y-axis, and each over a 2-day period in February, 2007 on the x-axis

library(data.table)


#read in the data (using absolute file location references)

filePath <- "C:\\Users\\Casey\\Documents\\ORSA STUFF\\ANALYSIS TOOLS\\Data Analysis\\Johns Hopkins Data Science Specialty\\Exploratory_Data_analysi\\Assignment1\\household_power_consumption.txt"
data <- fread(filePath, na.strings = c("?", "NA"), colClasses = c("Date", "character", 
                                                                  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
head(data) #Take a look at the top of the data 

#Subset to data from the dates 2007-02-01 to 2007-02-02.
data2 <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

#Create a vector of dates-times strings from the first two columns of the data
dates_times_strings <- c(1:nrow(data2))
for(i in 1:nrow(data2)){
  dates_times_strings[i] <- paste(data2[i,1],data2[i,2], sep = " ")
}

#change the vector of date-time strings into a list containing Date types
dates_times <- sapply(as.data.frame(dates_times_strings), strptime, "%d/%m/%Y %H:%M:%S")

#Open a png device and create the png file to send the plot to

png(file = "plot4.png")

#Set the parameters in order to show four plots on the output device

par(mfrow = c(2,2))

#Create a plot of the global active power data

with(data2, plot(dates_times[1]$dates_times_strings, Global_active_power, 
                 xlab = "", ylab = "Global Active Power", type = "n"))
lines(dates_times[1]$dates_times_strings, data2$Global_active_power)

#Create a plot of the voltage data
with(data2, plot(dates_times[1]$dates_times_strings, Voltage, 
                 xlab = "datetime", ylab = "Voltage", type = "n"))
lines(dates_times[1]$dates_times_strings, data2$Voltage)

#Create a plot fo the sub metering data

with(data2, plot(dates_times[1]$dates_times_strings, Sub_metering_1, 
                 xlab = "", ylab = "Energy sub metering", type = "n"))
lines(dates_times[1]$dates_times_strings, data2$Sub_metering_1, col = "black")
lines(dates_times[1]$dates_times_strings, data2$Sub_metering_2, col = "red")
lines(dates_times[1]$dates_times_strings, data2$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#Create a plot of the global reactive power
with(data2, plot(dates_times[1]$dates_times_strings, Global_reactive_power, 
                 xlab = "datetime", ylab = "Global_reactive_power", type = "n"))
lines(dates_times[1]$dates_times_strings, data2$Global_reactive_power)


#Close the png device
dev.off()
