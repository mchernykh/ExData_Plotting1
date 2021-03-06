invisible(
{
	# reading data
	fn <- "household_power_consumption.txt"
	options(stringsAsFactors = FALSE)
	d <- read.table(fn, sep = ";", header = TRUE)
	d[d == "?"] <- NA
	sapply(3:9, function(i) d[, i] <<- as.numeric(d[,i]))
	
	
	d$DateTime <- paste(d$Date, d$Time)
	d$DateTime <- strptime(d$DateTime, "%d/%m/%Y %H:%M:%S")
	d <- subset(d, select = -c(1, 2))
	
	ds <- d[as.Date(d$DateTime) %in% as.Date(c("2007-02-01", "2007-02-02")),]
	
	Sys.setlocale("LC_TIME", "English")
	
	png(file = "plot3.png")
	plot(ds$DateTime, ds$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")	
	lines(ds$DateTime, ds$Sub_metering_1, col = "black")
	lines(ds$DateTime, ds$Sub_metering_2, col = "red")
	lines(ds$DateTime, ds$Sub_metering_3, col = "blue")
	legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), pch = NA, lty = 1)
	dev.off()
	# data differs from provided in course page plot 3... why? who knows.
}
)
