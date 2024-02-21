###Metabolism
David_annotation=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Metabolism/DAVID_annotation.csv",stringsAsFactors = F)
Metabolism_subnetwork=David_annotation[grep(pattern="Metaboli",David_annotation[,8],ignore.case = T),]
Metabolic_Term=unique(unlist(strsplit(Metabolism_subnetwork[,8],split = ",")))
Metabolic_Term=Metabolic_Term[grep(pattern="Metaboli",Metabolic_Term,ignore.case = T)]
Metabolic_Term=Metabolic_Term[-c(2,3,8,10,11,12,14,15,20)]
Met=matrix(nrow = 1,ncol = 11)
Node=matrix(nrow = 59,ncol = 2)
colnames(Met)=colnames(Metabolism_subnetwork)
for(i in 1:dim(Metabolism_subnetwork)[1]){
  pathway=unique(unlist(strsplit(Metabolism_subnetwork[i,8],split = ",")))
  if(length(intersect(pathway,Metabolic_Term))>0){
    Met=rbind(Met,Metabolism_subnetwork[i,])
    Node[i,1]=Metabolism_subnetwork[i,1]
    Node[i,2]=paste(intersect(pathway,Metabolic_Term),collapse = "/")
  }
}
Met=na.omit(Met)
Node=na.omit(Node)
write.csv(Met,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Metabolism/Metabolism.csv",quote = F)
write.csv(Node,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Metabolism/Node_Matrix.csv",quote = F)

HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv")
Metabolism_Subnetwork=HCIP[which(HCIP[,2] %in% Met[,1]),]
write.csv(Metabolism_Subnetwork,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Metabolism/Metabolism_Subnetwork.csv",quote = F)



