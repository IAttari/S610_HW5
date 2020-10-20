setwd("C:\\Users\\imana\\GitHub\\S610_HW5")
library (microbenchmark)
source("llr_functions.R")


library(reshape2)
data(french_fries)
french_fries = french_fries[complete.cases(french_fries),]
z = seq(0, 15, length.out = 100)
x = french_fries$potato
y = french_fries$buttery

print(microbenchmark(
  llr(z = z, x = x, y = y, omega = 2),
  times = 300
))