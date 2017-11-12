#Code below reads in electric power consumption data from the file 
# "household_power_consumption.txt", then makes a line plot of energy sub-metering
# on the y-axis over a 2-day period in February, 2007 on the x-axis for each of the 
# three sub-meters.

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

png(file = "plot3.png")

#Create a plot of the sub metering data

with(data2, plot(dates_times[1]$dates_times_strings, Sub_metering_1, 
                 xlab = "", ylab = "Energy sub metering", type = "n"))
lines(dates_times[1]$dates_times_strings, data2$Sub_metering_1, col = "black")
lines(dates_times[1]$dates_times_strings, data2$Sub_metering_2, col = "red")
lines(dates_times[1]$dates_times_strings, data2$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#Close the png device
dev.off()
