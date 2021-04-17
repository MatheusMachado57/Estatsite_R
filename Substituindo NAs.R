

x = c(10, 5, 5, 10, NA, NA);
x
x[is.na(x)] = mean(x,na.rm=TRUE);
x
