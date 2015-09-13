plot4 <- function() {
      #library used
      library(sqldf)
      library(tcltk)
      
      #-------------
      #read data
      #-------------
      fileData <- "household_power_consumption.txt"
      
      #the file must exits in the current directory
      if (!file.exists(fileData)) {
            message("file data not exits")
            return(-1)
      }
      
      #read only the rows with the column "Date" is between 1/2/2007 --- 2/2/2007
      hh <- read.csv.sql(fileData, 
                         sql="select * from file where Date='1/2/2007' or Date='2/2/2007'",
                         sep=";")
      
      #change Date format
      hh$Date <- ifelse(hh$Date == "1/2/2007","2007-02-01","2007-02-02")
      #format Date-Time
      hh$dt <- strptime(str_c(hh$Date,hh$Time,sep=" "),"%Y-%m-%d %H:%M:%S")
      
      #--------------
      #--- Plot 4 ---
      #--------------
      
      png(file="plot4.png")
      
      par(mfrow=c(2,2))
      
      # plot 1
      plot(hh$dt, hh$Global_active_power, type="l",
           ylab = "Global Active Power", 
           xlab="")
      
      # plot 2
      plot(hh$dt, hh$Voltage, type="l",
           ylab = "Voltage", 
           xlab="datetime")
      
      #plot 3
      with(hh, plot(hh$dt, 
                    hh$Sub_metering_1, 
                    type="l",
                    ylab="Energy sub metering",
                    xlab = ""))
      with(hh, lines(hh$dt, hh$Sub_metering_2,type = "l", col="red"))
      with(hh, lines(hh$dt, hh$Sub_metering_3,type = "l", col="blue"))
      legend("topright", lty=1,  cex=0.8, bty = "n", 
             col = c("black","red","blue"),
             legend = c("Sub_metering_1", 
                        "Sub_metering_2",
                        "Sub_metering_3"))
      
      #plot 4
      plot(hh$dt, hh$Global_reactive_power, type="l",
           ylab="Global_reactive_power",
           xlab="datetime")
      
      dev.off()
      
    return(0)
}