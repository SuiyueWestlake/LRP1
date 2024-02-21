enhancement_suppression=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Postive_Negative_regulator/Investigating the Genetic Circuitry of Mastermind in Drosophila, a Notch Signal Effector/genetics.107.080994-4.csv")
Merge_Matrix=merge(enhancement_suppression, FB_of_HCIP, by.x = "FBgn", by.y = "V1")
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/HCIP&PreyInteractions.csv",header = T,as.is=T)
Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")
HCIP_enhancement_suppression=unique(Merge_Matrix[,14])
enhancement_suppression_Matrix=c()
for (n in 1:2007) {
  if( (HCIP[n,1] %in% HCIP_enhancement_suppression & HCIP[n,2] %in% HCIP_enhancement_suppression) | (HCIP[n,1] %in% Bait_Name & HCIP[n,2] %in% HCIP_enhancement_suppression) | (HCIP[n,1] %in% HCIP_enhancement_suppression & HCIP[n,2] %in% Bait_Name) | (HCIP[n,1] %in% Bait_Name & HCIP[n,2] %in% Bait_Name)){
    enhancement_suppression_Matrix[n]=paste(HCIP[n,1:2],collapse = ",")
  }
}
enhancement_suppression_Matrix=na.omit(enhancement_suppression_Matrix)
enhancement_suppression_Matrix=unique(enhancement_suppression_Matrix)
M=matrix(ncol = 2,nrow = 88)
for (i in 1:88) {
  M[i,1]=unlist(strsplit(enhancement_suppression_Matrix[i],","))[1]
  M[i,2]=unlist(strsplit(enhancement_suppression_Matrix[i],","))[2]
}
###网络去重
for(i in 1:dim(M)[1]){
  if(M[i,1]>=M[i,2]){
    a=M[i,1]
    b=M[i,2]
    M[i,1]=b
    M[i,2]=a
  }
}

HCIP_Enhance_Suppress=c()
for (i in 1:dim(M)[1]) {
  HCIP_Enhance_Suppress[i]=paste(M[i,1:2],collapse = ",")
}
HCIP_Enhance_Suppress=unique(HCIP_Enhance_Suppress)

write.csv(HCIP_Enhance_Suppress,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Postive_Negative_regulator/Investigating the Genetic Circuitry of Mastermind in Drosophila, a Notch Signal Effector/Network_enhancement_suppression.csv")



###提取点的属性
Node_Matrix=Merge_Matrix[,c(3,14)]
Node_Matrix=Node_Matrix[-c(4:6),]
Node_Matrix=Node_Matrix[-13,]
write.csv(Node_Matrix,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Postive_Negative_regulator/Investigating the Genetic Circuitry of Mastermind in Drosophila, a Notch Signal Effector/Node_Matrix.csv")
