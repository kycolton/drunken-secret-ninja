library(R.matlab)
library(reshape)
library(animation)
library(ggplot2)
library(e1071)

ip <- readMat('Data/Indian_pines_corrected.mat')
ip <- array(unlist(ip),dim=c(145,145,200))
gt <- readMat('Data/Indian_pines_gt.mat')

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

