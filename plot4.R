###download file and store in current working directory
LinkURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
mainDir <- "./Exploratory Data Analysis"

if (file.exists(mainDir)) {
  setwd(file.path(mainDir))
} else {
  dir.create(file.path(mainDir))
  setwd(file.path(mainDir))
}

download.file(LinkURL,destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")

## Read file in R in .csv format
householdpower <- read.table("./household_power_consumption.txt",header=TRUE,sep=";")

##Subset the data
subhouseholdpower <- subset(householdpower,as.Date(householdpower$Date,format = "%d/%m/%Y") <= "2007-02-02" & as.Date(householdpower$Date,format = "%d/%m/%Y") >= "2007-02-01")

##read in dates and times
dates <- as.Date(subhouseholdpower$Date,format="%d/%m/%Y")
times <- as.character(subhouseholdpower$Time)

##combine the dates and times
x <- paste(dates,times)
z <- strptime(x, "%Y-%m-%d %H:%M:%S")

##Add new column to table
subhouseholdpower$NewTimes <- z

par(mfrow=c(2,2))
##Plot 1
plot(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Global_active_power)),type = "l",xlab = "", ylab = "Global Active Power(kilowatts)")

##Plot 2
plot(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Voltage)),type = "l",xlab = "datetime", ylab = "Voltage")

##Plot 3
plot(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Sub_metering_1)),type = "l",xlab = "", ylab = "Global Active Power(kilowatts)")
lines(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Sub_metering_2)),type = "l",col="red")
lines(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Sub_metering_3)),type = "l",col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n",lty=1, col=c("black","red","blue"),cex = 0.75)

##plot 4
plot(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Global_reactive_power)),type = "l",xlab = "datetime", ylab = "Global_reactive_power")

##print png
dev.copy(png,'plot4.png')
dev.off()