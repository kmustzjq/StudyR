# Packages
library(zoo)

# Start RNG
set.seed(10)

# Sample data
tmp <- data.frame(time = 1:30, 
                  velocity = round(runif(30, 1, 3), digits = 2))

# Moving average (window size = 5) using rollmean
rollmean(tmp[, 2], k = 5, fill = NA)
# [1]    NA    NA 1.806 1.694 1.682 1.620 1.588 1.726 1.896 2.014 1.952 1.944 1.916 1.828 1.620 1.680 1.602 1.792 1.966 2.192 2.396 2.378 2.206 2.142
# [25] 2.232 2.018 2.184 2.164    NA    NA

# Moving average (window size = 5) using rollapply
rollapply(tmp[, 2], width = 5, function(...) {round(mean(...), digits = 3)}, partial = TRUE)
# [1] 1.823 1.965 1.806 1.694 1.682 1.620 1.588 1.726 1.896 2.014 1.952
# [12] 1.944 1.916 1.828 1.620 1.680 1.602 1.792 1.966 2.192 2.396 2.378
# [23] 2.206 2.142 2.232 2.018 2.184 2.164 2.103 1.910