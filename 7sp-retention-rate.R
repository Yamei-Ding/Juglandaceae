pdf("~/Desktop/add-result/7sp-blast2Vvi.retain.collinear-Chr1.pdf",height = 12,width = 12)
data=read.table("~/Desktop/2021-Rch/2022-Fractionation/Rch2Vvi.retain.collinear",header=T)
data<-data[data$ref_chr=="Chr1",]
p1<- ggplot(data=data)+geom_line(aes(x=pos,y=retain_rate,color=label),size=1)+
  scale_color_manual(values = c("blue","#44c1f0","Thistle4"),
                     breaks = c("D","S","both"),
                     labels = c("Dominant","Recessive","Both"),
                     name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title = element_text(size=10),
        axis.text= element_text(size=8,colour = "black"),
        axis.text.x= element_text(size=8))+
  scale_y_continuous(breaks=seq(0,2,0.2),limits = c(0,1.0), expand=c(0,0))+
  labs(x="Vitis vinifera Chr1",y="Retention rate")

data=read.table("~/Desktop/2021-Rch/2022-Fractionation/Aro2Vvi.retain.collinear",header=T)
data<-data[data$ref_chr=="Chr1",]
p2<- ggplot(data=data)+geom_line(aes(x=pos,y=retain_rate,color=label),size=1)+
  scale_color_manual(values = c("blue","#44c1f0","Thistle4"),
                     breaks = c("D","S","both"),
                     labels = c("Dominant","Recessive","Both"),
                     name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title = element_text(size=10),
        axis.text= element_text(size=8,colour = "black"),
        axis.text.x= element_text(size=8))+
  scale_y_continuous(breaks=seq(0,2,0.2),limits = c(0,1.0), expand=c(0,0))+
  labs(x="Vitis vinifera Chr1",y="Retention rate")

data=read.table("~/Desktop/2021-Rch/2022-Fractionation/Pla2Vvi.retain.collinear",header=T)
data<-data[data$ref_chr=="Chr1",]
p3<- ggplot(data=data)+geom_line(aes(x=pos,y=retain_rate,color=label),size=1)+
  scale_color_manual(values = c("blue","#44c1f0","Thistle4"),
                     breaks = c("D","S","both"),
                     labels = c("Dominant","Recessive","Both"),
                     name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title = element_text(size=10),
        axis.text= element_text(size=8,colour = "black"),
        axis.text.x= element_text(size=8))+
  scale_y_continuous(breaks=seq(0,2,0.2),limits = c(0,1.0), expand=c(0,0))+
  labs(x="Vitis vinifera Chr1",y="Retention rate")

data=read.table("~/Desktop/2021-Rch/2022-Fractionation/Cil2Vvi.retain.collinear",header=T)
data<-data[data$ref_chr=="Chr1",]
p4<- ggplot(data=data)+geom_line(aes(x=pos,y=retain_rate,color=label),size=1)+
  scale_color_manual(values = c("blue","#44c1f0","Thistle4"),
                     breaks = c("D","S","both"),
                     labels = c("Dominant","Recessive","Both"),
                     name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title = element_text(size=10),
        axis.text= element_text(size=8,colour = "black"),
        axis.text.x= element_text(size=8))+
  scale_y_continuous(breaks=seq(0,2,0.2),limits = c(0,1.0), expand=c(0,0))+
  labs(x="Vitis vinifera Chr1",y="Retention rate")

data=read.table("~/Desktop/2021-Rch/2022-Fractionation/Jre2Vvi.retain.collinear",header=T)
data<-data[data$ref_chr=="Chr1",]
p5<- ggplot(data=data)+geom_line(aes(x=pos,y=retain_rate,color=label),size=1)+
  scale_color_manual(values = c("blue","#44c1f0","Thistle4"),
                     breaks = c("D","S","both"),
                     labels = c("Dominant","Recessive","Both"),
                     name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title = element_text(size=10),
        axis.text= element_text(size=8,colour = "black"),
        axis.text.x= element_text(size=8))+
  scale_y_continuous(breaks=seq(0,2,0.2),limits = c(0,1.0), expand=c(0,0))+
  labs(x="Vitis vinifera Chr1",y="Retention rate")

data=read.table("~/Desktop/2021-Rch/2022-Fractionation/Jma2Vvi.retain.collinear",header=T)
data<-data[data$ref_chr=="Chr1",]
p6<- ggplot(data=data)+geom_line(aes(x=pos,y=retain_rate,color=label),size=1)+
  scale_color_manual(values = c("blue","#44c1f0","Thistle4"),
                     breaks = c("D","S","both"),
                     labels = c("Dominant","Recessive","Both"),
                     name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title = element_text(size=10),
        axis.text= element_text(size=8,colour = "black"),
        axis.text.x= element_text(size=8))+
  scale_y_continuous(breaks=seq(0,2,0.2),limits = c(0,1.0), expand=c(0,0))+
  labs(x="Vitis vinifera Chr1",y="Retention rate")

data=read.table("~/Desktop/2021-Rch/2022-Fractionation/Jmi2Vvi.retain.collinear",header=T)
data<-data[data$ref_chr=="Chr1",]
p7<- ggplot(data=data)+geom_line(aes(x=pos,y=retain_rate,color=label),size=1)+
  scale_color_manual(values = c("blue","#44c1f0","Thistle4"),
                     breaks = c("D","S","both"),
                     labels = c("Dominant","Recessive","Both"),
                     name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.title = element_text(size=10),
        axis.text= element_text(size=8,colour = "black"),
        axis.text.x= element_text(size=8))+
  scale_y_continuous(breaks=seq(0,2,0.2),limits = c(0,1.0), expand=c(0,0))+
  labs(x="Vitis vinifera Chr1",y="Retention rate")

p1+p2+p3+p4+p5+p6+p7+plot_layout(ncol = 2)
dev.off()
