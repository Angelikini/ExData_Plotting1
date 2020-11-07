#Exploratory Data Analysis
#Week 1 Project

#Import data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "~/epc.zip")

epc<-read.table(unz("epc.zip","household_power_consumption.txt")
                ,header=TRUE,sep = ";",na.strings = "?")
epc$Date <- as.Date(epc$Date, "%d/%m/%Y")
epc <- subset(epc,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
epc <- epc[complete.cases(epc),]
dateTime <- paste(epc$Date, epc$Time)
dateTime <- setNames(dateTime, "DateTime")## Name the vector
epc <- epc[ ,!(names(epc) %in% c("Date","Time"))]## Remove Date and Time column
epc <- cbind(dateTime, epc)## Add DateTime column
epc$dateTime <- as.POSIXct(dateTime)## Format dateTime Column

#Create plot 3

with(epc,
     {plot(Sub_metering_1~dateTime,
     type = "l",
     ylab="Energy sub metering",
     xlab="",)
      lines(Sub_metering_2~dateTime,
      col="red")
      lines(Sub_metering_3~dateTime,
      col="blue")
      legend("topright", col=c("black", "red", "blue"),  
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=1, cex=0.50 )
})

## Save file and close device

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()