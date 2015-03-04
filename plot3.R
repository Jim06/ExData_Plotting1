# script for Project 1 in Exploratory Data Analysis - Plot 3
# step 1 - download data
  setwd("C:/Users/Jim/R-Prog/Explore")
  myurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  myzip <- "power"
  download.file(myurl,myzip)
  
# step 2 - extract needed file from zip file
  filelist <- unzip(myzip, list=TRUE)
  top_20 <- read.table(unzip(myzip,filelist[1,1]),nrows=20,header=TRUE,sep=";",stringsAsFactors=FALSE, na.strings="?")
  colclass <- sapply(top_20,class)  
  consumption <- read.table(unzip(myzip, filelist[1,1]), colClasses=colclass, header=TRUE,sep=";", na.strings="?")

# step 3 - extract information for 2 specific dates
  library(lubridate)
  consumption[,1]<- dmy(consumption[,1]); consumption[,2]<- hms(consumption[,2])
  date1 <- ymd("2007-02-01"); date2 <- ymd("2007-02-02") 
  extract <- consumption[(consumption$Date == date1 | consumption$Date == date2),]
  extract[,1] <- extract[,1] + extract[,2]
  
# step 4 - create multiple time series line graphs for Plot 3
  png(filename = "plot3.png", width=480, height=480)
  plot(extract$Date,extract$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="grey30")
  points(extract$Date, extract$Sub_metering_2, type="l",col="red")
  points(extract$Date, extract$Sub_metering_3, type="l",col="blue")
  legend("topright", lty = 1, col = c("grey30", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
  