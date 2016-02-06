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
elec=read.table("data/household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE) ;
# Convert the dates to date format
elec$Date=as.Date(elec$Date, "%d/%m/%Y");
# Subset the data
mydata=subset(elec, Date==as.Date("2007-02-01", "%Y-%m-%d")| Date== as.Date("2007-02-02", "%Y-%m-%d"))
# Change the desired column data to numeric
mydata$Global_active_power=as.numeric(mydata$Global_active_power);
# Add a column DateTime to the data
mydata$DateTime=as.POSIXct(paste(mydata$Date, mydata$Time), format="%Y-%m-%d %H:%M:%S")

# set the graphics device
png(filename = "data/plot2.png",width = 480, height = 480, units = "px", type = "quartz");
# draw an empty plot
with(mydata, plot(Global_active_power~DateTime, type="n", ylab="Global Active Power (killowats)", xlab=""));
# Add lines to it.
lines(mydata$Global_active_power ~mydata$DateTime, lwd=2);
# close the device
dev.off();
