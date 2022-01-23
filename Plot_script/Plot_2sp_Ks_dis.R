library(ggplot2)
library(reshape2)
setwd("/Users/yameiding/Desktop/2021-Rch/20211230-evolutionrate/ks")
#args <- commandArgs(TRUE)
data <- read.table("Rch_Cil.ks",header = F,sep="\t")
colnames(data) <- c("tree","Ks","Species")
data <- subset(data,data$Ks>0 && data$Ks<0.5)
p2 <- ggplot(data,aes(x=Ks,color=factor(Species)))  +
  #geom_hline(aes(yintercept=12), colour="#990000", linetype="dashed")
  geom_line(stat="density")  + xlim(0,0.5) + theme_bw()  +
  theme(axis.title = element_text(size=12),axis.text=element_text(size=12))+
  theme(panel.grid=element_blank())
p2
#p2+geom_vline(aes(xintercept=0.05), linetype="dotted")
ggsave("Rch_Cil_ks.pdf",p2,width=8,height=6,dpi=600)
subdata <- data[data$Species=="Rch",]
den <- density(subdata$Ks)
pos <- order(den$y,decreasing = TRUE)
x<- den$x[pos]
x[1]
