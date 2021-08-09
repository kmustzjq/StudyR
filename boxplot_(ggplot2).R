library(ggplot2)
bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
bp

bp + ggtitle("Plant growth")
## Equivalent to
# bp + labs(title="Plant growth")

# If the title is long, it can be split into multiple lines with \n
bp + ggtitle("Plant growth with\ndifferent treatments")

# Reduce line spacing and use bold text
bp + ggtitle("Plant growth with\ndifferent treatments") + 
  theme(plot.title = element_text(lineheight=.8, face="bold"))


library(ggplot2)

bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) +
  geom_boxplot()
bp
bp + coord_flip()#Swapping X and Y axes


# Discrete axis

# Manually set the order of a discrete-valued axis
bp + scale_x_discrete(limits=c("trt1","trt2","ctrl"))

# Reverse the order of a discrete-valued axis
# Get the levels of the factor
flevels <- levels(PlantGrowth$group)
flevels
#> [1] "ctrl" "trt1" "trt2"

# Reverse the order
flevels <- rev(flevels)
flevels
#> [1] "trt2" "trt1" "ctrl"

bp + scale_x_discrete(limits=flevels)

# Or it can be done in one line:
bp + scale_x_discrete(limits = rev(levels(PlantGrowth$group)))


bp + scale_x_discrete(breaks=c("ctrl", "trt1", "trt2"),
                      labels=c("Control", "Treat 1", "Treat 2"))


# Hide x tick marks, labels, and grid lines
bp + scale_x_discrete(breaks=NULL)

# Hide all tick marks and labels (on X axis), but keep the gridlines
bp + theme(axis.ticks = element_blank(), axis.text.x = element_blank())


# Make sure to include 0 in the y axis
bp + expand_limits(y=0)

# Make sure to include 0 and 8 in the y axis
bp + expand_limits(y=c(0,8))


# Specify tick marks directly
bp + coord_cartesian(ylim=c(5, 7.5)) + 
  scale_y_continuous(breaks=seq(0, 10, 0.25))  # Ticks from 0-10, every .25


bp + scale_y_reverse()



# Setting and hiding tick markers
# Setting the tick marks on an axis
# This will show tick marks on every 0.25 from 1 to 10
# The scale will show only the ones that are within range (3.50-6.25 in this case)
bp + scale_y_continuous(breaks=seq(1,10,1/4))

# The breaks can be spaced unevenly
bp + scale_y_continuous(breaks=c(4, 4.25, 4.5, 5, 6,8))

# Suppress ticks and gridlines
bp + scale_y_continuous(breaks=NULL)

# Hide tick marks and labels (on Y axis), but keep the gridlines
bp + theme(axis.ticks = element_blank(), axis.text.y = element_blank())
