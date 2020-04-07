rm(list = ls())
setwd("/Users/jromero/Documents/R/datasciencecoursera/data")
library(data.table)
library(dplyr)
library(lubridate)
# fread gratly improves loading speed
datos <- fread("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".") 
datos <- as_tibble (subset(datos,Date %in% c("1/2/2007","1/2/2007")))
datos <- datos %>%  mutate(Global_active_power=as.double(Global_active_power),
                           DateTime = lubridate::dmy_hms(paste(Date, Time, sep = " ")), 
                           Sub_metering_1 = as.double(Sub_metering_1),
                           Sub_metering_2 = as.double(Sub_metering_2),
                           Sub_metering_3 = as.double(Sub_metering_3),
                           ) %>% 
                    select(DateTime, Global_active_power, Sub_metering_1,Sub_metering_2,Sub_metering_3 )
# Prepare plot to PNG with subset data
png("plot3.png", width=480, height=480)
 plot(datos$DateTime, datos$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
 lines(datos$DateTime, datos$Sub_metering_2, type="l", col="red")
 lines(datos$DateTime, datos$Sub_metering_3, type="l", col="blue")
 legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
 
dev.off()