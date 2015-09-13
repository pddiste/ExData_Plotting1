plot1 <- function() {
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

      #--------------
      #--- Plot 1 ---
      #--------------
      
      png(file="plot1.png")
      
      hist(hh$Global_active_power, col = "red", main="Global Active Power", 
           xlab = "Global Active Power (kilowatts)", 
           ylim = c(0, 1200))
     
      dev.off()
      
      return(0)
}