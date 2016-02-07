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
png(filename = "data/plot4.png",width = 480, height = 480, units = "px", type = "quartz");
par(mfrow=c(2,2));
par(cex=0.6);


# Plot #1
with(mydata, plot(Global_active_power~DateTime, type="n", ylab= expression(bold('Global Active Power')), xlab=""));
lines(mydata$Global_active_power ~mydata$DateTime, lwd=2);

#Plot #2
with(mydata, plot(Voltage~DateTime, type="n", xlab="datetime"));
lines(mydata$Voltage ~mydata$DateTime, lwd=2);

# Plot #3
with(mydata, plot(Sub_metering_1~DateTime, type="n", ylab=expression(bold("Energy sub metering")), xlab=""));
lines(mydata$Sub_metering_1 ~mydata$DateTime, col="black", lwd=2);
lines(mydata$Sub_metering_2 ~mydata$DateTime, col="red", lwd=2);
lines(mydata$Sub_metering_3 ~mydata$DateTime, col="blue", lwd=2);
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue" ), lty=1, lwd=2, cex=0.6);

#Plot #4
with(mydata, plot(Global_reactive_power~DateTime, type="n", xlab="datetime"));
lines(mydata$Global_reactive_power ~mydata$DateTime, lwd=2);

# close the device
dev.off();