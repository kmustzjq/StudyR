x <- c(21, 62, 10, 53)
labels <- c("London", "New York", "Singapore", "Mumbai")
png(file = "city.jpg")
pie(x,labels)
dev.off()
pie(x, labels, main="City pie chart", col=rainbow(length(x)))



# Create the data for the chart.
H <- c(7,12,28,3,41)
M <- c("Mar","Apr","May","Jun","Jul")
# Give the chart file a name.
png(file = "barchart_months_revenue.png")
# Plot the bar chart.
barplot(H,names.arg=M,xlab="Month",ylab="Revenue",col="blue",
        main="Revenue chart",border="red")
# Save the file.
dev.off()




# Create the input vectors.
colors <- c("green","orange","brown")
months <- c("Mar","Apr","May","Jun","Jul")
regions <- c("East","West","North")
# Create the matrix of the values.
Values <- matrix(c(2,9,3,11,9,4,8,7,3,12,5,2,8,10,11),nrow=3,ncol=5,byrow=TRUE)
# Give the chart file a name.
png(file = "barchart_stacked.png")
# Create the bar chart.
barplot(Values,main="total revenue",names.arg=months,xlab="month",ylab="revenue",col=colors)
# Add the legend to the chart.
legend("topleft", regions, cex=1.3, fill=colors)
# Save the file.
dev.off()



#jianli  zhifangtu
# Create data for the graph.
v <- c(9,13,21,8,36,22,12,41,31,33,19)
# Give the chart file a name.
png(file = "histogram_lim_breaks.png")
# Create the histogram.
hist(v,xlab="Weight",col="green",border="red",xlim = c(0,40), ylim = c(0,5), breaks = 5 )
# Save the file.
dev.off()




# Create the data for the chart.
v <- c(7,12,28,3,41)
t <- c(14,7,6,19,3)
# Give the chart file a name.
png(file = "line_chart_2_lines.jpg")
# Plot the bar chart.
plot(v,type="o",col="red",xlab="Month",ylab="Rain fall",main="Rain fall chart")
lines(t, type="o", col="blue")
# Save the file.
dev.off()