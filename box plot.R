set.seed(1234)
dat <- data.frame(cond = factor(rep(c("A","B"), each=200)), 
                  rating = c(rnorm(200),rnorm(200, mean=.8)))
# View first few rows
head(dat)
#>   cond     rating
#> 1    A -1.2070657
#> 2    A  0.2774292
#> 3    A  1.0844412
#> 4    A -2.3456977
#> 5    A  0.4291247
#> 6    A  0.5060559
# A basic box plot
ggplot(dat, aes(x=cond, y=rating)) + geom_boxplot()

# A basic box with the conditions colored
ggplot(dat, aes(x=cond, y=rating, fill=cond)) + geom_boxplot()

# The above adds a redundant legend. With the legend removed:
ggplot(dat, aes(x=cond, y=rating, fill=cond)) + geom_boxplot() +
  guides(fill=FALSE)

# With flipped axes
ggplot(dat, aes(x=cond, y=rating, fill=cond)) + geom_boxplot() + 
  guides(fill=FALSE) + coord_flip() ## Rotate 90


# Add a diamond at the mean, and make it larger
ggplot(dat, aes(x=cond, y=rating,fill=cond)) + geom_boxplot() +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)
