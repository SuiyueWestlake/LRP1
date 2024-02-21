HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/HCIP&PreyInteractions.csv",header = T,as.is=T)
Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")

###
#write.table(unique(HCIP[,2]),"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Unique_HCIP_List.txt",quote = F,row.names = F,col.names = F)


###Four leukemia data sets
#ALL_One=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Amp:Del/ALL_TARGET.csv")
#Leukemia_Data=ALL_One[which(ALL_One[,4]=="AMP"),]

###Three data sets
SCC_One=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Amp:Del/SCC_Firehouse.csv")
SCC_Two=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Amp:Del/SCC_Pancancer.csv")
SCC_Three=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Amp:Del/SCC_TCGA_Nature.csv")
SCC_Data=rbind(SCC_One,SCC_Two,SCC_Three)

#length(unique(intersect(HCIP[,2],Leukemia_Data[,1])))
#length(unique(intersect(HCIP[,2],SCC_Data[,1])))
#length(intersect(unique(intersect(HCIP[,2],Leukemia_Data[,1])),unique(intersect(HCIP[,2],SCC_Data[,1]))))

HCIP_in_SCC=unique(intersect(HCIP[,2],SCC_Data[,1]))

Matrix_for_plot=matrix(nrow = length(HCIP_in_SCC),ncol = 3)
colnames(Matrix_for_plot)=c("HCIP","Amp in SCC","Del in SCC")
for (i in 1:length(HCIP_in_SCC)) {
  Matrix_for_plot[i,1]=HCIP_in_SCC[i]
  Matrix_for_plot[i,2]=sum(SCC_Data[which(SCC_Data[,1]==HCIP_in_SCC[i] & SCC_Data[,4]=="AMP"),5])
  Matrix_for_plot[i,3]=sum(SCC_Data[which(SCC_Data[,1]==HCIP_in_SCC[i] & SCC_Data[,4]=="HOMDEL"),5])
}


Index_2=which(Matrix_for_plot[,2]==0)
Matrix_for_plot=Matrix_for_plot[-Index_2,]
Index_3=which(Matrix_for_plot[,3]==0)
Matrix_for_plot=Matrix_for_plot[-Index_3,]


write.csv(Matrix_for_plot,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/cBioportal/Amp:Del/SCC_AMP_DEL_Matrix.csv",row.names = F)


plot(Matrix_for_plot[,2],Matrix_for_plot[,3])
