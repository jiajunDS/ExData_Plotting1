debug <- TRUE
#debug <- FALSE

## Loading full dataset
if (debug)
{
    print ("Loading full dataset")
}
fullDataset <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
fullDataset$Date <- as.Date(fullDataset$Date, format="%d/%m/%Y")

## Only using data from the dates 2007-02-01 and 2007-02-02.
if (debug)
{
    print ("Extracting dates 2007-02-01 and 2007-02-02")
}
data <- subset(fullDataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(fullDataset)

## Perform date conversion
if (debug)
{
    print ("Performing date conversion")
}
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Generate plot4
if (debug)
{
    print ("Generating plot4")
}
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="", cex=0.75)
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="", cex=0.75)
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Energy sub metering", xlab="", cex=0.75)
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="", cex=0.75)
})

## Save to plot4.png
if (debug)
{
    print ("Saving to plot4.png")
}
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
