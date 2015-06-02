library(R.matlab)
library(reshape)
library(animation)
library(ggplot2)

ip <- readMat('Data/Indian_pines_corrected.mat')
ip <- array(unlist(ip),dim=c(145,145,200))

n <- dim(ip)[1]; m <- dim(ip)[2]; z <- dim(ip)[3]

ip.long <- array(0,dim=c(n * m, 3, z))
for( i in 1:(z) )
{ ip.long[,,i] <- as.matrix(as.data.frame(melt(ip[,,i]))) }

for( i in 1:z )
{
    print(ggplot(as.data.frame(ip.long[,,i]),aes(V1,V2,color=V3))+geom_point())
    readline("Press <return> to continue") 
}

ip.df <- array(dim=c(m*n,z))
for( i in 1:n)
{
    for( j in 1:m )
    { ip.df[(i-1)*n+j,] <- ip[i,j,] }
}

ip.km <- kmeans(ip.df,5)

classed <- matrix(ip.km$cluster,nrow=n,ncol=m,byrow=T)

ip.km.df <- as.data.frame(cbind(rep(1:n,each=m),rep(1:m,n),ip.km$cluster))
names(ip.km.df) <- c('x','y','class')

ggplot(ip.km.df,aes(x,y,color=as.factor(class))) + geom_point()


saveGIF({for(i in 1:z)
{ print(
    ggplot(as.data.frame(melt(ip[,,i])),aes(value)) + geom_histogram(binwidth=1,aes(y=..density..)) + xlim(750,8250))
}}, interval=0.2, movie.name = 'histograms.gif')



#~ km3d <- function(x,k,v=F)
#~ {
#~     n <- dim(x)[1]; m <- dim(x)[2]; z <- dim(x)[3]
#~     entries <- sample(1:(n*m),k)
#~     means <- array(dim=c(z,k)); for(l in 1:length(entries)){ means[,l] <- x[ceiling(entries[l]/n),entries[l] %% m,] }
#~     dists = array(dim=c(n,m,k))
#~     converge <- FALSE
#~     old.labs <- labs <- array(dim=c(n,m))
#~     while( !converge )
#~     {
#~         for( j in 1:k )
#~         { dist[,,j] <- apply(x,1:2,function(y) {dist(cbind(y,means[k]))}) }
#~         labs <- apply(dist,1:2,which.min)
#~         if(old.labs == labs){ converge <- TRUE }
#~         if(v){ print("Round") }
#~         old.labs <- labs
#~     }
#~     return(labs)
#~ }
