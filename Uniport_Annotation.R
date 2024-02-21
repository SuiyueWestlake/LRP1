###Uniport Annotation
install.packages("tidyverse")
library(tidyverse)
Uniport=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Uniport_Annotation/Uniport.csv",stringsAsFactors = F)
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv",stringsAsFactors = F)
Preys=unique(HCIP$Prey)

Col=colnames(HCIP)
Col[2]="Entry.name"
colnames(HCIP)=Col
gene_annotation_EntryName=merge(HCIP,Uniport)

Col[2]="Gene.names"
colnames(HCIP)=Col
gene_annotation_GeneName=merge(HCIP,Uniport)

Col[2]="Gene.names...primary.."
colnames(HCIP)=Col
gene_annotation_Gene.names...primary..=merge(HCIP,Uniport)

Col[2]="Gene.names...synonym.."
colnames(HCIP)=Col
gene_annotation_Gene.names...synonym..=merge(HCIP,Uniport)

length(unique(c(gene_annotation_EntryName$Entry.name,gene_annotation_Gene.names...primary..$Gene.names...primary..,gene_annotation_Gene.names...synonym..$Gene.names...synonym..,gene_annotation_GeneName$Gene.names)))

colnames(gene_annotation_EntryName)[1] <- 'Prey'
colnames(gene_annotation_Gene.names...primary..)[1] <- 'Prey'
colnames(gene_annotation_Gene.names...synonym..)[1] <- 'Prey'
colnames(gene_annotation_GeneName)[1] <- 'Prey'
write.csv(gene_annotation_Gene.names...primary..,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Uniport_Annotation/S_Table.csv",row.names = F,quote = F)








