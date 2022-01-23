pdf("KAKS_NE.pdf",width = 8,height = 6)
setwd("~/Desktop/")
data<-read.table("~/Desktop/2021-Rch/2021/2222.csv",header = T,sep = ",")
x <- data$Species
y1 <- data$Ka.Ks
y2 <- data$Ne
library(plotrix)
xpos <- 1:7
twoord.plot(xpos,y1,xpos,y2,lylim=c(0.1,0.2),rylim=c(8000,26000), 
            lcol="#2A5CAA",rcol="#F05B72",xlab="Species",ylab="Ka/Ks",rylab="Ne",xticklab=x,halfwidth=0.2,type=c("bar","p"))
dev.off()
