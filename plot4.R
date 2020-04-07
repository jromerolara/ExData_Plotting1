rm(list = ls())
setwd("/Users/jromero/Documents/R/datasciencecoursera/data")
library(data.table)
library(dplyr)
library(lubridate)
# fread greatly improves loading speed
datos <- fread("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".") 
datos <- as_tibble (subset(datos,Date %in% c("1/2/2007","1/2/2007")))
datos <- datos %>%  mutate(Global_active_power=as.double(Global_active_power),
                           DateTime = lubridate::dmy_hms(paste(Date, Time, sep = " ")), 
                           Sub_metering_1 = as.double(Sub_metering_1),
                           Sub_metering_2 = as.double(Sub_metering_2),
                           Sub_metering_3 = as.double(Sub_metering_3),
                           Voltage        = as.double(Voltage),
                           Global_reactive_power
) %>% 
    select(DateTime, Global_active_power, Sub_metering_1,Sub_metering_2,Sub_metering_3, Voltage, Global_reactive_power )
# Prepare plot to PNG with subset data
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
# Plot all charts together
plot(datos$DateTime, datos$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datos$DateTime, datos$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datos$DateTime, datos$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
  lines(datos$DateTime, datos$Sub_metering_2, type="l", col="red")
  lines(datos$DateTime, datos$Sub_metering_3, type="l", col="blue")
    legend("topright", c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
plot(datos$DateTime, datos$Global_reactive_power, type="l", xlab="Time", ylab="Global Reactive Power")

dev.off()