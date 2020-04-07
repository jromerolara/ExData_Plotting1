rm(list = ls())
setwd("/Users/jromero/Documents/R/datasciencecoursera/data")
library(data.table)
library(dplyr)
# fread gratly improves loading speed
datos <- fread("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".") 
datos <- as_tibble (subset(datos,Date %in% c("1/2/2007","1/2/2007")))
datos <- datos %>%  mutate(Global_active_power=as.double(Global_active_power)) 
# Prepare plot to PNG with subset data
png("plot1.png", width=480, height=480)
hist(datos$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()


