# plot 3
# -- A. Path and File names local files -----------------------------------
        path_name <- getwd()
        File_name <- "/household_power_consumption.txt"
        path_file <- paste(path_name,File_name, sep = "")

# -- B. Make dataframe ----------------------------------------------------
        dtenergyuseheader <- data.frame
        dtenergyuse <- data.frame

# -- C. Read in Local file to dataframe (add header) ----------------------
        dtenergyuseheader <- read.table(path_file, sep = ";", header = FALSE, nrow = 1, stringsAsFactors = FALSE)
        dtenergyuse <- read.table(path_file, sep = ";", header = TRUE, nrow = 2880, skip = 66636 , stringsAsFactors = FALSE)
        colnames( dtenergyuse ) <- unlist(dtenergyuseheader)

# -- D. Coecrion Date & Time ----------------------------------------------
        dtenergyuse$Time <- strptime(paste(dtenergyuse$Date,dtenergyuse$Time , sep = ""), "%d/%m/%Y %H:%M:%S")
        dtenergyuse$Date <- as.Date(dtenergyuse$Date, "%d/%m/%Y")

# -- E Base Histogram -----------------------------------------------------

        ##plot 3

        ## get max value of the three sub metering and determined range
                yhigh = max(c(max(dtenergyuse$Sub_metering_1),max(dtenergyuse$Sub_metering_2),max(dtenergyuse$Sub_metering_3)))
                ylow = min(c(min(dtenergyuse$Sub_metering_1),min(dtenergyuse$Sub_metering_2),min(dtenergyuse$Sub_metering_3)))
                yrange <- rep_len(0, length(dtenergyuse$Sub_metering_1)-2)
                yrange = c(ylow, yhigh, yrange)

        
        #Save as PNG
        png(file = "plot3.png" , width = 480, height = 480 )
                plot(x=dtenergyuse$Time, y=yrange, type="n", ylab ="Energy sub metering")
                lines(x=dtenergyuse$Time, y=dtenergyuse$Sub_metering_1)
                lines(x=dtenergyuse$Time, y=dtenergyuse$Sub_metering_2, col="red")
                lines(x=dtenergyuse$Time, y=dtenergyuse$Sub_metering_3, col = "blue")
                legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red" , "blue") , cex = 0.8, lty=1)        
        dev.off()
