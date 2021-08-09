install.packages("recommenderlab")
install.packages("recosystem")

library(devtools)
install_github(repo = "SlopeOne", username = "tarashnot")
install_github(repo = "SVDApproximation", username = "tarashnot")
library(recommenderlab)
library(recosystem)
library(SlopeOne)
library(SVDApproximation)

library(data.table)
library(RColorBrewer)
library(ggplot2)
data(ratings)
head(ratings)

###create sparse_ratings
sparse_ratings <- sparseMatrix(i = ratings$user, j = ratings$item, x = ratings$rating, 
                               dims = c(length(unique(ratings$user)), length(unique(ratings$item))),  
                               dimnames = list(paste("u", 1:length(unique(ratings$user)), sep = ""), 
                                               paste("m", 1:length(unique(ratings$item)), sep = "")))
sparse_ratings[1:10, 1:10]