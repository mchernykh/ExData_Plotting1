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

	png(file = "plot2.png")
	plot(ds$DateTime, ds$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
	dev.off()
	# data differs from provided in course page plot 2... why? who knows.
}
)