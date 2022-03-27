## read the data from hw1_data.csv
data = read.csv("hw1_data.csv")
## eliminate the NA data
data = data[!is.na(data)]
## find the mean of Ozone
mean_ozone = mean(data$Ozone)
## make a plot showing ozone
plot(data$Ozone, type = "l", xlab = "Year", ylab = "Ozone")