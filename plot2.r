# plot 2

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
        ##plot 2
        #Save as PNG
        png(file = "plot2.png" , width = 480, height = 480 )
                plot(dtenergyuse$Time,y= dtenergyuse$Global_active_power, type="n", ylab = "Global Acitve Power (kilowatts)", xlab = "NOTE :Dutch Do, Vr, Za = English Thu, Fri, Sat" )
                lines.default(x= dtenergyuse$Time, y= dtenergyuse$Global_active_power, type = "l")
        dev.off()