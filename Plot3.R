# That R script allow to set up the right data set and make some graph from it
# / ! \ The days in the final plot will appear in french / ! \

# 1) Verify if dplyr and lubridate packages are installed and launch them : 

if (!require(dplyr)){
        install.packages("dplyr")
        library(dplyr)
} else {
        library(dplyr)       
} 

if (!require(lubridate)){
        install.packages("lubridate")
        library(lubridate)
} else {
        library(lubridate)       
}

# 2) Create the data set :
ds <- read.table("household_power_consumption.txt", 
                 sep = ";",
                 header = TRUE,
                 stringsAsFactors = FALSE,
                 na.strings = "?")
nw_ds <- ds %>%
        mutate(Full_Time = paste(Date, Time)) %>%
        mutate(Full_Time = dmy_hms(Full_Time)) %>%
        mutate(Date = dmy(Date)) %>%
        mutate(Time = hms(Time)) %>%
        filter(Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))

# 3) Create Plot 3 :
if(file.exists("Plot 3.png")){file.remove("Plot 3.png")}

with(nw_ds, plot(Sub_metering_1 ~ Full_Time,
                 type = "l",
                 xlab = "",
                 ylab ="Ernergy sub metering"))

lines(nw_ds$Full_Time, nw_ds$Sub_metering_1, col = "black")

lines(nw_ds$Full_Time, nw_ds$Sub_metering_2, col = "red")

lines(nw_ds$Full_Time, nw_ds$Sub_metering_3, col = "blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                lty = c(1,1,1),
                col=c("black","red","blue"))

dev.copy(png, file = "Plot 3.png",
         width = 480,
         height = 480, 
         units = "px")

dev.off()