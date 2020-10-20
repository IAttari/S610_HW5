llr = function(x, y, z, omega) {
  fits = sapply(z, compute_f_hat, x, y, omega)
  return(fits)
}

compute_f_hat = function(z, x, y, omega) {
  Wz = make_weight_matrix(z, x, omega)
  X = make_predictor_matrix(x)
  f_hat = c(1, z) %*% solve(t(X) %*% (sweep(X, 1, Wz, "*"))) %*% t(X) %*% matrix(Wz*y)
  return(f_hat)
}


make_predictor_matrix = function(x){
  X = matrix(1 ,nrow = length(x), ncol = 2)
  X[,2] <- x
  return(X)
}

make_weight_matrix = function(z, x, omega){
  j = 1
  W <- rep(0, length(x))
  r = abs(x - z)/omega
  for (i in r){
    if (abs(i) < 1) {
      W[j] = (1 - abs(i^3))^3
    } 
    j = j+1
  }
  return (W)
}


library(reshape2)
data(french_fries)
french_fries = french_fries[complete.cases(french_fries),]

z = seq(0, 15, length.out = 100)
fits = llr(z = z, x = french_fries$potato, y = french_fries$buttery, omega = 2)
plot(z, fits)