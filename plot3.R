# create the data directory in the current if it does not already exists
mainDir=getwd();
if (!file.exists("data"))
{
  dir.create(file.path(mainDir, "data"));
  
}
#download the files and unzip them
fileURL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
download.file(fileURL,destfile = "./data/Project1.zip", mode="wb");
unzip("data/Project1.zip", exdir="data");

# Read the data
elec=read.table("data/household_power_consumption.txt", header = TRUE, na.strings = "?", sep=";", stringsAsFactors = FALSE) ;
# Convert the dates to date format
elec$Date=as.Date(elec$Date, "%d/%m/%Y");
# Subset the data
mydata=subset(elec, Date==as.Date("2007-02-01", "%Y-%m-%d")| Date== as.Date("2007-02-02", "%Y-%m-%d"))
# Change the desired column data to numeric
mydata$Global_active_power=as.numeric(mydata$Global_active_power);
# Add a column DateTime to the data
mydata$DateTime=as.POSIXct(paste(mydata$Date, mydata$Time), format="%Y-%m-%d %H:%M:%S")

# set the graphics device
png(filename = "data/plot3.png",width = 480, height = 480, units = "px", type = "quartz");
# draw an empty plot
with(mydata, plot(Sub_metering_1~DateTime, type="n", ylab="Energy sub metering", xlab=""));
# Add lines to it.
lines(mydata$Sub_metering_1 ~mydata$DateTime, col="black", lwd=2);
lines(mydata$Sub_metering_2 ~mydata$DateTime, col="red", lwd=2);
lines(mydata$Sub_metering_3 ~mydata$DateTime, col="blue", lwd=2);
# Add legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue" ), lty=1, lwd=2);
# close the device
dev.off();
