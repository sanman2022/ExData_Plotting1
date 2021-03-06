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

# set the graphics device
png(filename = "data/plot1.png",width = 480, height = 480, units = "px", type = "quartz");
# draw the histogram
hist(mydata$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red");
# close the device
dev.off();
