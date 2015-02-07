# plot 1

# -- A. Path and File names local files -----------------------------------
        path_name <- getwd()
        File_name <- "/household_power_consumption.txt"
        path_file <- paste(path_name,File_name, sep = "")

# -- B. Make dataframe ----------------------------------------------------
        dtenergyuseheader <- data.frame()
        dtenergyuse <- data.frame()

# -- C. Read in Local file to dataframe (add header) ----------------------
        dtenergyuseheader <- read.table(path_file, sep = ";", header = FALSE, nrow = 1, stringsAsFactors = FALSE)
        dtenergyuse <- read.table(path_file, sep = ";", header = TRUE, nrow = 2880, skip = 66636 , stringsAsFactors = FALSE)
        colnames(dtenergyuse ) <- unlist(dtenergyuseheader)

# -- D. Coecrion Date & Time ----------------------------------------------
        dtenergyuse$Date <- as.Date(dtenergyuse$Date, "%d/%m/%Y")
        dtenergyuse$Time <- strptime(dtenergyuse$Time, "%H:%M:%S")




str(dtenergyuse)



# -- E Base Histogram -----------------------------------------------------
        #Save as PNG
        png(file = "plot1.png" , width = 480, height = 480 )
                hist(dtenergyuse$Global_active_power, main ="Global Active Power", xlab= "Global Active Power (kilowatts)", col="Red")
        dev.off()