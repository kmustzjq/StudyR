dat <- data.frame(
  time = factor(c("Lunch","Dinner"), levels=c("Lunch","Dinner")),
  total_bill = c(14.89, 17.23)
)
dat
#>     time total_bill
#> 1  Lunch      14.89
#> 2 Dinner      17.23

# Load the ggplot2 package
library(ggplot2)



# Very basic bar graph
ggplot(data=dat, aes(x=time, y=total_bill)) +
  geom_bar(stat="identity")


# Map the time of day to different fill colors
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) +
  geom_bar(stat="identity")

## This would have the same result as above
# ggplot(data=dat, aes(x=time, y=total_bill)) +
#    geom_bar(aes(fill=time), stat="identity")


# Add a black outline
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) +
  geom_bar(colour="black", stat="identity")


# No legend, since the information is redundant
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) +
  geom_bar(colour="black", stat="identity") +
  guides(fill=FALSE)



# Add title, narrower bars, fill color, and change axis labels
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) + 
  geom_bar(colour="black", fill="#DD8888", width=.8, stat="identity") + 
  guides(fill=FALSE) +
  xlab("Time of day") + ylab("Total bill") +
  ggtitle("Average bill for 2 people")




library(reshape2)
# Look at fist several rows
head(tips)
#>   total_bill  tip    sex smoker day   time size
#> 1      16.99 1.01 Female     No Sun Dinner    2
#> 2      10.34 1.66   Male     No Sun Dinner    3
#> 3      21.01 3.50   Male     No Sun Dinner    3
#> 4      23.68 3.31   Male     No Sun Dinner    2
#> 5      24.59 3.61 Female     No Sun Dinner    4
#> 6      25.29 4.71   Male     No Sun Dinner    4



# Bar graph of counts
ggplot(data=tips, aes(x=day)) +
  geom_bar(stat="count")
## Equivalent to this, since stat="bin" is the default:
# ggplot(data=tips, aes(x=day)) +
#    geom_bar()





# Basic line graph
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) +
  geom_line()
## This would have the same result as above
# ggplot(data=dat, aes(x=time, y=total_bill)) +
#     geom_line(aes(group=1))

# Add points
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) +
  geom_line() +
  geom_point()

# Change color of both line and points
# Change line type and point type, and use thicker line and larger points
# Change points to circles with white fill
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) + 
  geom_line(colour="red", linetype="dashed", size=1.5) + 
  geom_point(colour="red", size=4, shape=21, fill="white")







# Change the y-range to go from 0 to the maximum value in the total_bill column,
# and change axis labels
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) +
  geom_line() +
  geom_point() +
  expand_limits(y=0) +
  xlab("Time of day") + ylab("Total bill") +
  ggtitle("Average bill for 2 people")









################Graphs with more variables##################################

dat1 <- data.frame(
  sex = factor(c("Female","Female","Male","Male")),
  time = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
  total_bill = c(13.53, 16.81, 16.24, 17.42)
)
dat1
#>      sex   time total_bill
#> 1 Female  Lunch      13.53
#> 2 Female Dinner      16.81
#> 3   Male  Lunch      16.24
#> 4   Male Dinner      17.42


# Stacked bar graph -- this is probably not what you want
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity")

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity", position=position_dodge())

ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")

# Change colors
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black") +
  scale_fill_manual(values=c("#999999", "#E69F00"))













# Finished examples

# A bar graph
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) + 
  geom_bar(colour="black", stat="identity",
           position=position_dodge(),
           size=.3) +                        # Thinner lines
  scale_fill_hue(name="Sex of payer") +      # Set legend title
  xlab("Time of day") + ylab("Total bill") + # Set axis labels
  ggtitle("Average bill for 2 people") +     # Set title
  theme_bw()


# A line graph
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, shape=sex, colour=sex)) + 
  geom_line(aes(linetype=sex), size=1) +     # Set linetype by sex
  geom_point(size=3, fill="white") +         # Use larger points, fill with white
  expand_limits(y=0) +                       # Set y range to include 0
  scale_colour_hue(name="Sex of payer",      # Set legend title
                   l=30)  +                  # Use darker colors (lightness=30)
  scale_shape_manual(name="Sex of payer",
                     values=c(22,21)) +      # Use points with a fill color
  scale_linetype_discrete(name="Sex of payer") +
  xlab("Time of day") + ylab("Total bill") + # Set axis labels
  ggtitle("Average bill for 2 people") +     # Set title
  theme_bw() +
  theme(legend.position=c(.7, .4))           # Position legend inside
# This must go after theme_bw

