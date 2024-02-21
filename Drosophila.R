###Drosophila
Genotype_in_Drosophila=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drosophila/nature.csv",stringsAsFactors = F)
CG2FB=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drosophila/CG_of_HCIP.csv",header = F,stringsAsFactors = F)
colnames(CG2FB)=c("CG_Number_5.7","FB")
FB2HCIPs=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drosophila/FB2HCIP.csv",header = F)
colnames(FB2HCIPs)=c("FB","HCIPs")
Drosophila_data=merge(CG2FB,FB2HCIPs,all=FALSE)
Drosophila_data=merge(Drosophila_data,Genotype_in_Drosophila,all = FALSE)
write.csv(Drosophila_data,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drosophila/Drosophila_data.csv",quote = F)
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv",stringsAsFactors = F)

HCIP_in_Drosophila=HCIP[which(HCIP[,2] %in% Drosophila_data$HCIPs),]
write.csv(HCIP_in_Drosophila,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drosophila/HCIP_in_Drosophila.csv",quote = F)
Node_Matrix=matrix(ncol = 4,nrow = length(unique(HCIP_in_Drosophila$Prey)))
colnames(Node_Matrix)=c("HCIPs","Color","Shape","Border")
C=c(3,c(13:24))
Drosophila_data=Drosophila_data[1:1294,C]
D=as.data.frame(lapply(Drosophila_data[,2:13],as.numeric))
D$HCIP=Drosophila_data$HCIPs
D[is.na(D)] <- 0
k=1
row_number=c()
for (j in 1:dim(D)[1]) {
  if(sum(D[j,1:12])==0){
    row_number[k]=j
    k=k+1
  }
}
D=D[-row_number,]
length(unique(D$HCIP))
HCIP_in_Drosophila=HCIP_in_Drosophila[which(HCIP_in_Drosophila[,2] %in% D[,13]),]

Node_Matrix=matrix(nrow = length(unique(HCIP_in_Drosophila$Prey)),ncol = 6)
colnames(Node_Matrix)=c("HCIP","node_color","node_shape","border_shape","border_color","label_color")
Node_Matrix[,1]=as.character(unique(HCIP_in_Drosophila$Prey))
Bait=c("NOTCH1","NOTCH2","NOTCH3","NOTCH4","DLL1","DLL3","DLL4","RBPJ","MAML1","MAML2","MAML3","JAG1","JAG2")

for (i in 1:dim(Node_Matrix)[1]){
  rows=D[which(D$HCIP==Node_Matrix[i,1]),]
  if(sum(rows$Bristle_morphology_defects)>0){
    Node_Matrix[i,2]="Purple"
  }
  if(sum(rows$Loss_of_bristles)>0){
    Node_Matrix[i,2]="Orange"
  }
  if(sum(rows$Gain_of_bristles)>0){
    Node_Matrix[i,2]="Blue"
  }
  if(sum(rows$Loss_of_bristles)>0 & sum(rows$Gain_of_bristles)>0){
    Node_Matrix[i,2]="Yellow"
  }
  if(sum(rows$Hair_cell_duplication)>0){
    Node_Matrix[i,2]="Green"
  }
  if(sum(rows$Empty_or_multiple_sockets)>0){
    Node_Matrix[i,2]="Green"
  }
  if(Node_Matrix[i,1] %in% Bait){
    Node_Matrix[i,3]="Bait"
  }
  if(sum(rows$Notum_malformation_death)>0){
    Node_Matrix[i,3]="regular_triangle"
  }
  if(sum(rows$Completely_lethal)>0){
    Node_Matrix[i,3]="diamond"
    Node_Matrix[i,2]="black"
  }
  if(sum(rows$Overproliferation)>0){
    Node_Matrix[i,3]="down_triangle"
  }
  if(sum(rows$Planar_polarity_defects)>0){
    Node_Matrix[i,5]="Purple"
  }
  if(sum(rows$Colour_defects)>0){
    Node_Matrix[i,5]="Green"
  }
}
Node_Matrix[is.na(Node_Matrix)] <- 0
write.csv(Node_Matrix,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drosophila/Node_Matrix.csv",quote = F)


