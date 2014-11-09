#download the file via url and unzip
fileURl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURl, destfile="./Power.zip")
unzip("./Power.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)

#subset the file
power <- "./household_power_consumption.txt"
data <- read.table(power,
                   header = TRUE,
                   sep = ";",
                   colClasses = c("character", "character", rep("numeric",7)),
                   na = "?")
ncol(data) #9 columns
nrow(data) #2,075,259 rows

#format date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Subsetting the data
febdata <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##format time
datetime <- paste(as.Date(febdata$Date), febdata$Time)
febdata$Datetime <- as.POSIXct(datetime)


# Plot 3
png("plot3.png",width=480,height=480,units="px",bg="transparent")
plot(febdata$Datetime,febdata$Sub_metering_1,
     type ="l", xlab="",
     ylab="Energy sub metering",
)
lines(febdata$Datetime, febdata$Sub_metering_2, col = "red")
lines(febdata$Datetime, febdata$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
dev.off()
