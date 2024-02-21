HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/HCIP&PreyInteractions.csv",header = T,as.is=T)
Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")

###Four leukemia data sets
ALL_One=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Leukemia/ALL_TARGET_2018.csv")
CLL_Two=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Leukemia/CLL_Broad_2013.csv")
CLL_Three=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Leukemia/CLL_ICGC_2011.csv")
CLL_Four=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Leukemia/CLL_IUOPA_2015.csv")
Leukemia_Data=rbind(ALL_One,CLL_Two,CLL_Three,CLL_Four)

###Three data sets
SCC_One=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/SCC/SCC_TCGA_Firehouse.csv")
SCC_Two=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/SCC/SCC_TCGA_Nature_2015.csv")
SCC_Three=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/SCC/SCC_TCGA_PanCancerAtlas.csv")
SCC_Data=rbind(SCC_One,SCC_Two,SCC_Three)

#length(unique(intersect(HCIP[,2],Leukemia_Data[,1])))
#length(unique(intersect(HCIP[,2],SCC_Data[,1])))
#length(intersect(unique(intersect(HCIP[,2],Leukemia_Data[,1])),unique(intersect(HCIP[,2],SCC_Data[,1]))))

HCIP_in_Both_Leukemia_and_SCC=intersect(unique(intersect(HCIP[,2],Leukemia_Data[,1])),unique(intersect(HCIP[,2],SCC_Data[,1])))

Matrix_for_plot=matrix(nrow = 225,ncol = 3)
colnames(Matrix_for_plot)=c("HCIP","Mut in Leukemia","Mut in SCC")
for (i in 1:length(HCIP_in_Both_Leukemia_and_SCC)) {
  Matrix_for_plot[i,1]=HCIP_in_Both_Leukemia_and_SCC[i]
  Matrix_for_plot[i,2]=sum(Leukemia_Data[which(Leukemia_Data[,1]==HCIP_in_Both_Leukemia_and_SCC[i]),4])
  Matrix_for_plot[i,3]=sum(SCC_Data[which(SCC_Data[,1]==HCIP_in_Both_Leukemia_and_SCC[i]),4])
}

write.csv(Matrix_for_plot,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Matrix_for_dotplot.csv")


plot(Matrix_for_plot[,2],Matrix_for_plot[,3])
