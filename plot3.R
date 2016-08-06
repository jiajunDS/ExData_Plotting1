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

## Generate plot3
if (debug)
{
    print ("Generating plot3")
}
with(data, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Energy sub metering", xlab="",
         cex.lab=1, cex.axis=1, cex.main=1, cex.sub=1)
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)

## Save to plot3.png
if (debug)
{
    print ("Saving to plot3.png")
}
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
