library(R.matlab)
library(reshape)
library(animation)
library(ggplot2)
library(e1071)

ip <- readMat('Data/Indian_pines_corrected.mat')
ip <- array(unlist(ip),dim=c(145,145,200))
gt <- readMat('Data/Indian_pines_gt.mat')
gt <- array(unlist(gt),dim=c(145,145,200))

n <- dim(ip)[1]; m <- dim(ip)[2]; z <- dim(ip)[3]

ip.long <- array(0,dim=c(n * m, 3, z))
for( i in 1:(z) )
{ ip.long[,,i] <- as.matrix(as.data.frame(melt(ip[,,i]))) }

ip.df <- array(dim=c(m*n,z))
for( i in 1:n)
{
    for( j in 1:m )
    { ip.df[(i-1)*n+j,] <- ip[i,j,] }
}

# All GT Layers are identical
gt.long <- as.vector(t(gt[,,1]))

set.seed(48625)
train <- sample(1:length(gt.long),length(gt.long)/4)
test <- (1:length(gt.long))[-train]

#ip.pred <- predict(ip.svm,newdata=ip.df[test,])
#table(pred = ip.pred, true = as.factor(gt[test]))
error <- vector(length=100)

for( i in 1:100 )
{
	ip.svm <- svm(x=ip.df[train,], y=as.factor(gt.long[train]), cost = i)
	ip.pred <- predict(ip.svm,newdata=ip.df)
	svm.confusion <- table(pred = ip.pred, true = as.factor(gt.long))
	error[i] <- sum(diag(svm.confusion)) / sum(svm.confusion)
}

ip.svm.df <- as.data.frame(cbind(rep(1:n,each=m),rep(1:m,n),ip.pred))

names(ip.svm.df) <- c('x','y','land')

ggplot(ip.svm.df,aes(x,y,color=as.factor(land))) + geom_point()
