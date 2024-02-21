###Diseases_and_Disorders
install.packages("gplots")
library("gplots")
install.packages("pheatmap")
library("pheatmap")
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/HCIP_Diseases_and_Disorders.csv",as.is = T)
HCIP$Bait="HCIP"
Ligand=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/Ligand_Diseases.csv",as.is = T)
Ligand$Bait="Ligand"
MAML=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/MAML_Diseases.csv",as.is = T)
MAML$Bait="MAML"
NOTCH=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/NOTCH_Diseases.csv",as.is = T)
NOTCH$Bait="NOTCH"
RBPJ=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/RBPJ_Diseases.csv",as.is = T)
RBPJ$Bait="RBPJ"
Diseases_and_Disorders=rbind(HCIP,Ligand,MAML,NOTCH,RBPJ)
write.csv(Diseases_and_Disorders,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/Diseases_and_Disorders.csv")
HCIP=HCIP[,1:2]
colnames(HCIP)[2]="HCIP"
Ligand=Ligand[,1:2]
colnames(Ligand)[2]="Ligand"
MAML=MAML[,1:2]
colnames(MAML)[2]="MAML"
NOTCH=NOTCH[,1:2]
colnames(NOTCH)[2]="NOTCH"
RBPJ=RBPJ[,1:2]
colnames(RBPJ)[2]="RBPJ"
HeatMap_data=merge(merge(merge(merge(HCIP,Ligand,all = T),NOTCH,all = T),MAML,all = T),RBPJ,all = T)
rownames(HeatMap_data)=HeatMap_data[,1]
HeatMap_data=HeatMap_data[,-1]
H=matrix(nrow = dim(HeatMap_data)[1],ncol = dim(HeatMap_data)[2])
colnames(H)=colnames(HeatMap_data)
row.names(H)=row.names(HeatMap_data)
for (i in 1:dim(HeatMap_data)[2]) {
  for (j in 1:dim(HeatMap_data)[1]) {
    H[j,i] = -log10(as.numeric(paste(strsplit(HeatMap_data[j,i],"-")[[1]][1],strsplit(HeatMap_data[j,i],"-")[[1]][2],sep = "-")))
    print(class(H[j,i]))
  }
}
H[is.na(H)] <- 1
Order=order(H[,1],decreasing = T)
H=H[Order,]
bk <- c(seq(1,10,by=1))
pheatmap(H,cluster_rows = F,cluster_cols = F) 
pheatmap(H,cluster_rows = F,cluster_cols = F, color = c(colorRampPalette(colors = c("white","#4575b4"))(20),
                                                        colorRampPalette(colors = c("#4575b4","#4575b4"))(80)),)  

#HCIP_Molecular_and_Cellular_Functions.csv
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/HCIP_Molecular_and_Cellular_Functions.csv",as.is = T)
HCIP$Bait="HCIP"
Ligand=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/Ligand_Molecular.csv",as.is = T)
Ligand$Bait="Ligand"
MAML=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/MAML_Molecular.csv",as.is = T)
MAML$Bait="MAML"
NOTCH=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/NOTCH_Molecular.csv",as.is = T)
NOTCH$Bait="NOTCH"
RBPJ=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/RBPJ_Molecular.csv",as.is = T)
RBPJ$Bait="RBPJ"
Molecular_and_Cellular_Functions=rbind(HCIP,Ligand,MAML,NOTCH,RBPJ)
write.csv(Molecular_and_Cellular_Functions,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/Molecular_and_Cellular_Functions.csv")
HCIP=HCIP[,1:2]
colnames(HCIP)[2]="HCIP"
Ligand=Ligand[,1:2]
colnames(Ligand)[2]="Ligand"
MAML=MAML[,1:2]
colnames(MAML)[2]="MAML"
NOTCH=NOTCH[,1:2]
colnames(NOTCH)[2]="NOTCH"
RBPJ=RBPJ[,1:2]
colnames(RBPJ)[2]="RBPJ"
HeatMap_data=merge(merge(merge(merge(HCIP,Ligand,all = T),NOTCH,all = T),MAML,all = T),RBPJ,all = T)
rownames(HeatMap_data)=HeatMap_data[,1]
HeatMap_data=HeatMap_data[,-1]
H=matrix(nrow = dim(HeatMap_data)[1],ncol = dim(HeatMap_data)[2])
colnames(H)=colnames(HeatMap_data)
row.names(H)=row.names(HeatMap_data)
for (i in 1:dim(HeatMap_data)[2]) {
  for (j in 1:dim(HeatMap_data)[1]) {
    H[j,i] = -log10(as.numeric(paste(strsplit(HeatMap_data[j,i],"-")[[1]][1],strsplit(HeatMap_data[j,i],"-")[[1]][2],sep = "-")))
    print(class(H[j,i]))
  }
}
H[is.na(H)] <- 1
Order=order(H[,1],decreasing = T)
H=H[Order,]
bk <- c(seq(1,10,by=1))
pheatmap(H,cluster_rows = F,cluster_cols = F) 
pheatmap(H,cluster_rows = F,cluster_cols = F, color = c(colorRampPalette(colors = c("white","#4575b4"))(20),
                                                        colorRampPalette(colors = c("#4575b4","#4575b4"))(80)),)  

###Physiological_System_Developments
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/HCIP_Physiological_System_Developments.csv",as.is = T)
HCIP$Bait="HCIP"
Ligand=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/Ligand_Physiological.csv",as.is = T)
Ligand$Bait="Ligand"
MAML=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/MAML_Physiological.csv",as.is = T)
MAML$Bait="MAML"
NOTCH=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/NOTCH_Physiological.csv",as.is = T)
NOTCH$Bait="NOTCH"
RBPJ=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/RBPJ_Physiological.csv",as.is = T)
RBPJ$Bait="RBPJ"
Physiological_System_Developments=rbind(HCIP,Ligand,MAML,NOTCH,RBPJ)
write.csv(Physiological_System_Developments,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/IPA/Physiological_System_Developments.csv")
HCIP=HCIP[,1:2]
colnames(HCIP)[2]="HCIP"
Ligand=Ligand[,1:2]
colnames(Ligand)[2]="Ligand"
MAML=MAML[,1:2]
colnames(MAML)[2]="MAML"
NOTCH=NOTCH[,1:2]
colnames(NOTCH)[2]="NOTCH"
RBPJ=RBPJ[,1:2]
colnames(RBPJ)[2]="RBPJ"
HeatMap_data=merge(merge(merge(merge(HCIP,Ligand,all = T),NOTCH,all = T),MAML,all = T),RBPJ,all = T)
rownames(HeatMap_data)=HeatMap_data[,1]
HeatMap_data=HeatMap_data[,-1]
H=matrix(nrow = dim(HeatMap_data)[1],ncol = dim(HeatMap_data)[2])
colnames(H)=colnames(HeatMap_data)
row.names(H)=row.names(HeatMap_data)
for (i in 1:dim(HeatMap_data)[2]) {
  for (j in 1:dim(HeatMap_data)[1]) {
    H[j,i] = -log10(as.numeric(paste(strsplit(HeatMap_data[j,i],"-")[[1]][1],strsplit(HeatMap_data[j,i],"-")[[1]][2],sep = "-")))
    print(class(H[j,i]))
  }
}
H[is.na(H)] <- 1
Order=order(H[,1],decreasing = T)
H=H[Order,]
bk <- c(seq(1,20,by=1))
pheatmap(H,cluster_rows = F,cluster_cols = F) 
pheatmap(H,cluster_rows = F,cluster_cols = F, color = c(colorRampPalette(colors = c("white","#4575b4"))(50),
                                                        colorRampPalette(colors = c("#4575b4","#4575b4"))(50)),)  
Tox_Functions=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP/Pathways.csv",as.is = T,stringsAsFactors = F)
#for (i in 1:dim(Tox_Functions)[1]) {
#  Tox_Functions[i,2] = -log10(as.numeric(paste(strsplit(Tox_Functions[i,2],"-")[[1]][1],strsplit(Tox_Functions[i,2],"-")[[1]][2],sep = "-")))
#}
Tox_Functions[,2]=as.numeric(Tox_Functions[,2])
Order=order(Tox_Functions[,2],decreasing = T)
rownames(Tox_Functions)=Tox_Functions[,1]
Tox_Functions=Tox_Functions[Order[1:40],]
library(ggplot2)
ggplot(data=Tox_Functions, aes(x=Ingenuity.Canonical.Pathways, y=X.log.p.value.,fill=Ingenuity.Canonical.Pathways), fill=Ingenuity.Canonical.Pathways) +
  geom_bar(stat="identity",width = 0.5)+guides(fill=FALSE)+
  theme(panel.grid =element_blank())+
  ylim(0,12)+
  scale_x_discrete(limits=Tox_Functions$Ingenuity.Canonical.Pathways)+
  theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 0.5,color = "black",size=9))
barplot(Tox_Functions[,2])
