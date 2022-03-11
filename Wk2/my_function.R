add2 <- function(x, y) {
    x + y
}

above10 <- function(x){
    use <- x > 10
    x[use]
}

above <- function(x, n = 10) { ## specify default value
    use <- x > n
    x[use]
}

colunmmean <- function(y, removeNA = TURE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc){
          means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means
}