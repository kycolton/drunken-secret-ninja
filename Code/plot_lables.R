# R code for generating a plot from the 'labels' data gotten out of the Matlab
# K-means function

library(ggplot2)

labels <- t(read.csv('labels.csv',header=F))
table(labels)
n <- sqrt(length(labels))
# n = 145
map <- data.frame(cbind(labels,rep(1:n,n),rep(1:n,each=n)))
names(map) <- c('label','x','y')

ggplot(map,aes(x,y,color=as.factor(label)))+geom_point(shape=15,size=2)
