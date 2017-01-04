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

# 3) Create Plot 4 :

if (file.exists("Plot 4.png")){file.remove("Plot 4.png")}

par(mfrow = c(2,2))

# Plot in the topleft :
with(nw_ds, plot(Global_active_power ~ Full_Time,
                 type = "l",
                 xlab = "",
                 ylab ="Global active power"))

# Plot in the topright :
with(nw_ds, plot(Voltage ~ Full_Time,
                 type = "l",
                 xlab = "datetime",
                 ylab ="Voltage"))


# Plot in the bottomleft :
with(nw_ds, plot(Sub_metering_1 ~ Full_Time,
                 type = "l",
                 xlab = "",
                 ylab ="Ernergy sub metering"))

lines(nw_ds$Full_Time, nw_ds$Sub_metering_1, col = "black")

lines(nw_ds$Full_Time, nw_ds$Sub_metering_2, col = "red")

lines(nw_ds$Full_Time, nw_ds$Sub_metering_3, col = "blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1),
       col=c("black","red","blue"),
       bty = "n")

# Plot in the bottomright :
with(nw_ds, plot(Global_reactive_power ~ Full_Time,
                 type = "l",
                 xlab = "datetime",
                 ylab ="Global reactive power"))

dev.copy(png, file = "Plot 4.png",
         width = 480,
         height = 480, 
         units = "px")

dev.off()