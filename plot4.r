# plot 4

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

        ## get max value of the three sub metering and determined range
                yhigh = max(c(max(dtenergyuse$Sub_metering_1),max(dtenergyuse$Sub_metering_2),max(dtenergyuse$Sub_metering_3)))
                ylow = min(c(min(dtenergyuse$Sub_metering_1),min(dtenergyuse$Sub_metering_2),min(dtenergyuse$Sub_metering_3)))
                yrange <- rep_len(0, length(dtenergyuse$Sub_metering_1)-2)
                yrange = c(ylow, yhigh, yrange)


        #Save as PNG
        png(file = "plot4.png" , width = 480, height = 480 )

                par(mfrow = c(2,2) )
                with(dtenergyuse, {
             
                #plot 1
                        plot(dtenergyuse$Time,y= dtenergyuse$Global_active_power, type="n", ylab = "Global Acitve Power", xlab = "" )
                        lines.default(x= dtenergyuse$Time, y= dtenergyuse$Global_active_power, type = "l")
                
                #plot2
                        plot(x=dtenergyuse$Time, y=dtenergyuse$Voltage, type="n" , xlab = "datetime" , ylab = "Voltage")
                        lines(x=dtenergyuse$Time, y=dtenergyuse$Voltage)
                
                # plot3
                        plot(x=dtenergyuse$Time, y=yrange, type="n", xlab ="",ylab = "Energy sub metering")
                        lines(x=dtenergyuse$Time, y=dtenergyuse$Sub_metering_1)
                        lines(x=dtenergyuse$Time, y=dtenergyuse$Sub_metering_2, col="red")
                        lines(x=dtenergyuse$Time, y=dtenergyuse$Sub_metering_3, col = "blue")
                        legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red" , "blue") , cex = 0.8, lty=1)
                
                
                #plot 4
                        plot(x=dtenergyuse$Time, y=dtenergyuse$Global_reactive_power, type="n" , xlab = "datetime" , ylab = "Global_reactive_power")
                        lines(x=dtenergyuse$Time, y=dtenergyuse$Global_reactive_power)
                        })
        dev.off()