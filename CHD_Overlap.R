### CHD先天性心脏病与HCIP的overlap
CHD_T9=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/CHD/Table S9. De novo mutations in cases.csv",as.is = F)
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/HCIP&PreyInteractions.csv",header = T,as.is=T)
Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")
CHD_T10=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/CHD/Table S10. De novo mutations in controls.csv")
CHD_T3=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/CHD/Table S3- List of damaging recessive genotypes in CHD case cohort.csv")
CHD_T2=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/CHD/Table S2- 253 Curated known Human:Mouse CHD genes.csv")

###五个基因"CHD7" "DYNC2H1" "FBN2" "NOTCH1" "LRP1"
candidate_genes=intersect(CHD_T3$Gene,intersect(HCIP[,2],CHD_T9$Gene))
damaging_recessive_genotypes=matrix(ncol = 12,nrow = 1)
colnames(damaging_recessive_genotypes)=colnames(CHD_T3)
de_novo_mutation=matrix(ncol = 17,nrow = 1)
colnames(de_novo_mutation)=colnames(CHD_T9)
for (i in candidate_genes) {
  genotype=CHD_T3[which(CHD_T3[,5]==i),]
  damaging_recessive_genotypes=rbind(damaging_recessive_genotypes,genotype)
  mutation=CHD_T9[which(CHD_T9$Gene==i),]
  de_novo_mutation=rbind(de_novo_mutation,mutation)
}
damaging_recessive_genotypes=na.omit(damaging_recessive_genotypes)
de_novo_mutation=na.omit(de_novo_mutation)
write.csv(damaging_recessive_genotypes,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/CHD/damaging_recessive_genotypes.csv")
write.csv(de_novo_mutation,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/CHD/de_novo_mutation.csv")




