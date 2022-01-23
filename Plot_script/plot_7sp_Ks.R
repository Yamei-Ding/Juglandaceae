data<-read.table("~/median-Ks/all.ks")
ggplot(data=data,aes(x=V1,group=V2))+
  stat_density(aes(color=V2,linetype=V2),size=0.6,geom = "line", position = "identity")+
  scale_color_manual(values = c("Peru" ,"SteelBlue3","#6B8E23","red","green","blue","black"),
                     breaks = c("Aro" ,"Cil","Jma","Jmi","Jre","Pla","Rch"),
                     #change name
                     labels=c("Aro","Cil","Jma","Jmi","Jre","Pla","R.chiliantha"),
                     name="")+
  scale_linetype_manual(values=c("solid","solid","solid","solid","solid","solid","dashed"),
                        breaks =c("Aro" ,"Cil","Jma","Jmi","Jre","Pla","Rch"),
                        #change name
                        labels=c("Aro","Cil","Jma","Jmi","Jre","Pla","R.chiliantha"),
                        name="")+
  theme(panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.text.x = element_text(family="serif",size=11),
        axis.text.y = element_text(family="serif",size=11),
        axis.title.x = element_text(family="serif",size=14),
        axis.title.y = element_text(family="serif",size=14),
        legend.text = element_text(size="12",family="serif",face="bold.italic"),
        legend.position = c(0.9,0.7),
        legend.key =  element_blank(),
        plot.title = element_text(hjust = 0.5),
        plot.tag.position=c(0.8,0.8),
        plot.tag=element_text(hjust = 0))+
  scale_x_continuous(breaks = seq(0,5,0.5),limits = c(0,5))+
  labs(x="Synomymous nocleotide subsititution (Ks)",
       y="No. of syntenic blocks kernel density",title="")
subdata<-data[data$V2=="Rch",]
den<-density(subdata$V1)
pos<-order(den$y,decreasing=TRUE)
x<-den$x[pos]
x[1]
x<-x[x<1]
x[1]