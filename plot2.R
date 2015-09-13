plot2 <- function() {
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
      #--- Plot 2 ---
      #--------------
      
      png(file="plot2.png")
      
      plot(hh$dt, hh$Global_active_power, type="l",
           ylab = "Global Active Power (kilowatts)", 
           xlab="")
      
      dev.off()
      
      return(0)
}