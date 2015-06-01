library(R.matlab)
ip <- readMat('Data/Indian_pines_corrected.mat')
ip <- array(unlist(ip),dim=c(145,145,200))
ip.long <- array(0,dim=c(dim(ip)[1] * dim(ip)[2], 3, dim(ip)[3]))
for( i in 1:(dim(ip)[3]) )
{ ip.long[,,i] <- as.matrix(as.data.frame(melt(ip[,,i]))) }
library(ggplot2)
for( i in 1:200 )
{
    print(ggplot(as.data.frame(ip.long[,,i]),aes(V1,V2,color=V3))+geom_point())
    readline("Press <return to continue") 
}
