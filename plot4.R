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

#Create plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(epc,{
  plot(Global_active_power~dateTime,
       type = "l",
       ylab="Global Active Power (kilowatts)",
       xlab="")
  plot(Voltage~dateTime,
       type = "l",
       ylab="Voltage",
       xlab="datetime")
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
                lty=1, lwd=2, cex=0.50)
       })
  plot(Global_reactive_power~dateTime,
       type = "l",
       ylab="Global_reactive_power",
       xlab="datetime")
  })

## Save file and close device

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()