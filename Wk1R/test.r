install.packages("ggplot2")
install.packages("data.table")
library(ggplot2)
library(data.table)
iris <- as.data.table(iris)
ggplot(iris, aes(Ozone, Solar.R, Wind, Temp, Month, Day) )+ geom_point()

