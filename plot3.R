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

##plot the line charts
plot(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Sub_metering_1)),type = "l",xlab = "", ylab = "Global Active Power(kilowatts)")
lines(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Sub_metering_2)),type = "l",col="red")
lines(subhouseholdpower$NewTimes, as.numeric(as.character(subhouseholdpower$Sub_metering_3)),type = "l",col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"),cex = 1)

##print png
dev.copy(png,'plot3.png')
dev.off()