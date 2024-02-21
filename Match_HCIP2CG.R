### Match HCIP的蛋白质ID和果蝇的CG_ID
HCIP_in_Drosophila=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/HCIP_in_Drosophila.csv",header = F,as.is = T)
CG_of_HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/FlyBase/CG_of_HCIP.csv",header = F,as.is=T)
HCIP_in_Paper=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP_in_Paper.csv",header = T,as.is = T)
colnames(HCIP_in_Drosophila)=c("FB","Symbol")
colnames(CG_of_HCIP)=c("CG_Number_5.7","FB")
Merge_Data_1 <- merge(x = HCIP_in_Drosophila, y = CG_of_HCIP, by = "FB")
Merge_Data_2 <- merge(x = Merge_Data_1, y = HCIP_in_Paper, by = "CG_Number_5.7")
Merge_Data_3=Merge_Data_2[,c(1,2,3,12,14,15,16,17,18,19,20,23)]
Merge_Data_3_NA=na.omit(Merge_Data_3)
Merge_Data_3_NA[which(Merge_Data_3_NA[,5]>0),5]=1 #只要该列值大于0，都认为有表型，都改为1
Merge_Data_3_NA[which(Merge_Data_3_NA[,6]>0),6]=1
Merge_Data_3_NA[which(Merge_Data_3_NA[,7]>0),7]=1
Merge_Data_3_NA[which(Merge_Data_3_NA[,8]>0),8]=1
Merge_Data_3_NA[which(Merge_Data_3_NA[,9]>0),9]=1
Merge_Data_3_NA[which(Merge_Data_3_NA[,10]>0),10]=1
Merge_Data_3_NA[which(Merge_Data_3_NA[,11]>0),11]=1

Phenotype=c()
k=1
Symbol_List = unique(Merge_Data_3_NA[,3])
for (i in 1:length(Symbol_List)){
  row_number=which(Merge_Data_3_NA[,3]==Symbol_List[i])
  for (j in row_number) {
    Phenotype[k]=paste(Merge_Data_3_NA[j,3:12],collapse=",")
    k=k+1
  }
}
Unique_Phenotype=unique(Phenotype)

Matrix=matrix(nrow = length(Unique_Phenotype),ncol = 10)
for (h in 1:length(Unique_Phenotype) ) {
  Matrix[h,]=unlist(strsplit(Unique_Phenotype[h],","))
}
colnames(Matrix)=colnames(Merge_Data_3_NA)[3:12]

Unique_Matrix=matrix(nrow = 302,ncol = 10)
h=1
for (n in 1:302) {
  if (length(which(Matrix[,1]==Symbol_List[n]))>1) {
    Unique_Matrix[h,]=Matrix[which(Matrix[,1]==Symbol_List[n])[1],]
    h=h+1
  }
  if (length(which(Matrix[,1]==Symbol_List[n]))==1) {
    Unique_Matrix[h,]=Matrix[which(Matrix[,1]==Symbol_List[n])[1],]
    h=h+1
  }
}
colnames(Unique_Matrix)=colnames(Matrix)


HCIP_Prey_Interactions=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/HCIP&PreyInteractions.csv",header = T,as.is = T)
Network_List=c()
k=1
for (n in 1:dim(HCIP_Prey_Interactions)[1]) {
  Network_List[k]=paste(HCIP_Prey_Interactions[n,1:2],collapse=",")
  k=k+1
}


Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")
Network_List=unique(Network_List)
Network_Matrix=matrix(nrow = length(Network_List),ncol = 2)
for (h in 1:length(Network_List) ) {
  Pairs=unlist(strsplit(Network_List[h],","))
  #
  if( (Pairs[1] %in% Symbol_List & Pairs[2] %in% Symbol_List) | (Pairs[1] %in% Bait_Name & Pairs[2] %in% Symbol_List) | (Pairs[1] %in% Symbol_List & Pairs[2] %in% Bait_Name) ){
    Network_Matrix[h,]=Pairs
  }
  
}
Network_Matrix=na.omit(Network_Matrix)
write.csv(Network_Matrix,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/Prey2Prey_Network_Matrix.csv", quote = F,row.names = F)

###设定节点的属性
Node_Matrix=matrix(ncol = 8,nrow = 302)
colnames(Node_Matrix)=c("Node","Lethality_NodeColor","Bristles_NodeShape","Hair/Sockets_NodeBorder","ColorDefect_NodeBorderColor","Bristle_morphology_defects","Planar_Polarity_defects","Overproliferation")
Node_Matrix[,1]=Unique_Matrix[,1]
Node_Matrix[,2]=Unique_Matrix[,2]
for(i in 1:302) {
  if( Unique_Matrix[i,3]==1 ){
    Node_Matrix[i,3]=2
  }
  if(  Unique_Matrix[i,4]==1 ){
    Node_Matrix[i,3]=1
  }
  if( Unique_Matrix[i,3]==1 & Unique_Matrix[i,4]==1){
    Node_Matrix[i,3]=3
  }
  if( Unique_Matrix[i,5]==1 | Unique_Matrix[i,6]==1){
    Node_Matrix[i,4]=1
  }
}
Node_Matrix[,5]=Unique_Matrix[,7]
Node_Matrix[,6]=Unique_Matrix[,8]
Node_Matrix[,7]=Unique_Matrix[,9]
Node_Matrix[,8]=Unique_Matrix[,10]

Final_Node=matrix(ncol = 2, nrow = 302 )
for (n in 1:302) {
  Final_Node[n,1]=Node_Matrix[n,1]
  Final_Node[n,2]=paste(Node_Matrix[n,2:8],collapse = "-")
}

#Node_Matrix[is.na(Node_Matrix)]=1000

write.csv(Final_Node,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey2PreyNetwork/Final_Node.csv", quote = F,row.names = F)

