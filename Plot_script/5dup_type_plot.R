library(ggplot2)
setwd("/Users/yameiding/Desktop/2021-Rch/20211230-evolutionrate/dup_type")
data <- read.table("dup.result",header = F)
colnames(data) <- c("Dup_type","Number","Species")
p2 <- ggplot() +
  geom_bar(data = data, aes(x = Species, y=Number,fill = factor(Dup_type)),stat = "identity",position = "fill")+
  theme_bw() +
  theme(panel.grid =element_blank())+
  theme(panel.border = element_blank())+
  theme(axis.line = element_line(size=0.5, colour = "black"),axis.text.x = element_text(size = 10, vjust = 0.5, hjust = 0.5),axis.text.y = element_text(size = 10, vjust = 0.5, hjust = 0.5)) +
  labs(x = "Species",y = "Proportion")
#pdf("6sp_dup_type.pdf",width=6,height=6)
#dev.off()
p2
ggsave("7sp_dup_type.pdf",p2,width=8,height=6,dpi=600)
