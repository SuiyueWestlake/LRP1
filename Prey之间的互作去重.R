Prey_Prey_interactions=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Prey_Prey_interaction.csv",header = F,as.is = T)
Prey_interactions_List=matrix(ncol = 2,nrow = 1966)
for(i in 1:dim(Prey_Prey_interactions)[1]){
  if(Prey_Prey_interactions[i,3]>=Prey_Prey_interactions[i,4]){
    a=Prey_Prey_interactions[i,3]
    b=Prey_Prey_interactions[i,4]
    Prey_Prey_interactions[i,3]=b
    Prey_Prey_interactions[i,4]=a
    Prey_interactions_List[i,1]=b
    Prey_interactions_List[i,2]=a
  }
  if(Prey_Prey_interactions[i,3]<Prey_Prey_interactions[i,4]){
    Prey_interactions_List[i,1]=Prey_Prey_interactions[i,3]
    Prey_interactions_List[i,2]=Prey_Prey_interactions[i,4]
  }
}

Unique_Prey_interactions_list=unique(paste(Prey_interactions_List[,1], Prey_interactions_List[,2], sep = " "))
Matrix_for_write=matrix(nrow = 1166,ncol = 2)
for (j in 1:length(Unique_Prey_interactions_list)) {
  writeline=strsplit(Unique_Prey_interactions_list[j], split = ' ')
  Matrix_for_write[j,1]= writeline[[1]][1]
  Matrix_for_write[j,2]= writeline[[1]][2]
}

write.csv(Matrix_for_write,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Unique_Prey_Prey_interaction.csv", quote = F,row.names = F)





