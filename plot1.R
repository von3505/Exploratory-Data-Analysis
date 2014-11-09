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

# Plot 1
png("plot1.png",width=480,height=480,units="px",bg="transparent")
hist(febdata$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power",
     ylim = c(0, 1200))
dev.off()
