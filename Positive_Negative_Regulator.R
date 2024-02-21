###Positive_Regulator & Negative Regulator
P_N_Regulator=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/A combined ex vivo and in vivo RNAi screen for notch regulators in Drosophila reveals an extensive notch interaction network/P_N_Regulator.csv",header = T,as.is=T)
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/HCIP&PreyInteractions.csv",header = T,as.is=T)
FB_of_HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/HCIP_in_Drosophila.csv",header = F,as.is=T)
Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")
Regulator_HCIP_FB=intersect(FB_of_HCIP[,1],P_N_Regulator[,3])
Regulator_HCIP_ProteinName=c()
FB_ProteinName_Matrix=matrix(nrow = 68,ncol = 3)
for (i in 1:68) {
  Regulator_HCIP_ProteinName[i]=FB_of_HCIP[which(FB_of_HCIP[,1]==Regulator_HCIP_FB[i]),2]
  FB_ProteinName_Matrix[i,1:2]=c(Regulator_HCIP_FB[i],Regulator_HCIP_ProteinName[i])
  FB_ProteinName_Matrix[i,3]=P_N_Regulator[which(P_N_Regulator[,3]==Regulator_HCIP_FB[i]),1]
}

Regulator_Matrix=c()
for (n in 1:2007) {
  if( (HCIP[n,1] %in% Regulator_HCIP_ProteinName & HCIP[n,2] %in% Regulator_HCIP_ProteinName) | (HCIP[n,1] %in% Bait_Name & HCIP[n,2] %in% Regulator_HCIP_ProteinName) | (HCIP[n,1] %in% Regulator_HCIP_ProteinName & HCIP[n,2] %in% Bait_Name) ){
    Regulator_Matrix[n]=paste(HCIP[n,1:2],collapse = ",")
  }
}
Regulator_Matrix=na.omit(Regulator_Matrix)
Regulator_Matrix=unique(Regulator_Matrix)
M=matrix(ncol = 2,nrow = 130)
for (i in 1:130) {
  M[i,1]=unlist(strsplit(Regulator_Matrix[i],","))[1]
  M[i,2]=unlist(strsplit(Regulator_Matrix[i],","))[2]
}

for(i in 1:dim(M)[1]){
  if(M[i,1]>=M[i,2]){
    a=M[i,1]
    b=M[i,2]
    M[i,1]=b
    M[i,2]=a
  }
}

HCIP_Regulators=c()
for (i in 1:dim(M)[1]) {
  HCIP_Regulators[i]=paste(M[i,1:2],collapse = ",")
}
HCIP_Regulators=unique(HCIP_Regulators)
write.csv(HCIP_Regulators,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/A combined ex vivo and in vivo RNAi screen for notch regulators in Drosophila reveals an extensive notch interaction network/Regulator_Matrix.csv", quote = F,row.names = F)
write.csv(FB_ProteinName_Matrix,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/A combined ex vivo and in vivo RNAi screen for notch regulators in Drosophila reveals an extensive notch interaction network/Regulator_Node_Matrix.csv", quote = F,row.names = F)
