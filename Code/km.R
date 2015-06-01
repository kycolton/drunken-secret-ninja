library(R.matlab)
ip <- readMat('Data/Indian_pines_corrected.mat')
ip <- array(unlist(ip),dim=c(145,145,200))
#~ ip.long <- array(0,dim=c(dim(ip)[1] * dim(ip)[2], 3, dim(ip)[3]))
#~ for( i in dim(ip)[3] )
#~ {
#~     ip.long[,,i] <- as.data.frame(melt(ip[,,i]))
#~ }
a <- as.data.frame(melt(ip[,,100]))
library(ggplot2)
ggplot(a,aes(X1,X2,color=value))+geom_point()
