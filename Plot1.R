# That R script allow to set up the right data set and make some graph from it

# 1) Verify if dplyr and tidyr packages are installed and launch them : 

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
        mutate(Date = dmy(Date)) %>%
        mutate(Time = hms(Time)) %>%
        filter(Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))

# 3) Create Plot 1 :

if (file.exists("Plot 1.png")){file.remove("Plot 1.png")}

with(nw_ds, hist(Global_active_power,
                 col = "red",
                 xlab = "Global active power (kilowatts)",
                 ylab ="Frequency",
                 main = "Global Active Power"))        

dev.copy(png, file = "Plot 1.png",
         width = 480,
         height = 480, 
         units = "px")

dev.off()
