HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv",stringsAsFactors = F)
pharmacologically_active_drug=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drugbank/drugbank_approved_target_polypeptide_ids/pharmacologically_active.csv",stringsAsFactors = F)
all=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drugbank/drugbank_approved_target_polypeptide_ids/all.csv",stringsAsFactors = F)
intersect(pharmacologically_active_drug[,10],HCIP[,2])
intersect(all[,10],HCIP[,2])

pharmacologically_active_drug_Target=intersect(pharmacologically_active_drug[,10],HCIP[,2])
all_approved_target=intersect(all[,10],HCIP[,2])

approved_target_Matrix=matrix(ncol = 13,nrow = 1000)
k=1
for (i in 1:38) {
  Row=which(all[,10]==all_approved_target[i])
  for (j in Row) {
    approved_target_Matrix[k,]=as.matrix(all[j,])
    k=k+1
  }
}
approved_target_Matrix=approved_target_Matrix[1:44,]
#approved_target_Matrix=na.omit(approved_target_Matrix)
colnames(approved_target_Matrix)=colnames(all)
write.csv(approved_target_Matrix,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drugbank/approved_target_Matrix.csv",quote = F)



k=1
Drug_Target_matrix=matrix(nrow=100000,ncol = 2)
length(unique(all[,10]))
for (i in all_approved_target) {
  Drug_list=all[which(all[,10]==i),13]
  Drug_list=as.character(Drug_list)
  if(length(Drug_list)>1){
    for (m in Drug_list) {
      Drug_Target_matrix[k,1]=i
      Drug_Target_matrix[k,2]=m
      k=k+1
    }
  }
  else{
    Drug_Target_matrix[k,1]=i
    Drug_Target_matrix[k,2]=Drug_list
    k=k+1
  }
}

Drug_Target_matrix=na.omit(Drug_Target_matrix)

n=1
Drug_Target_matrix_one2one=matrix(ncol = 2,nrow = 10000)
for(j in 1:length(Drug_Target_matrix[,1])){
  Drug=unlist(strsplit(Drug_Target_matrix[j,2],";"))
  if(length(Drug)>=1){
    for (d in Drug) {
      Drug_Target_matrix_one2one[n,1]=Drug_Target_matrix[j,1]
      Drug_Target_matrix_one2one[n,2]=d
      n=n+1
    }
  }
  #else{
  #  Drug_Target_matrix_one2one[n,1]=j
  #  Drug_Target_matrix_one2one[n,2]=Drug
  #}
}

Drug_Target_matrix_one2one=na.omit(Drug_Target_matrix_one2one)
Drug_ID=matrix(nrow = dim(Drug_Target_matrix_one2one)[1],1)
Drug_Target_matrix_one2one_New=cbind(Drug_Target_matrix_one2one,Drug_ID)
Drug_Target_matrix_one2one_New=gsub(" ", "", Drug_Target_matrix_one2one_New)
Drugbank_Vocabulary=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drugbank/drugbank vocabulary.csv")
for (q in 1:dim(Drug_Target_matrix_one2one_New)[1]) {
  row_number=which(Drugbank_Vocabulary[,1]==Drug_Target_matrix_one2one_New[q,2])
  Drug_Target_matrix_one2one_New[q,3]=as.character(Drugbank_Vocabulary[row_number,3])
  
}
write.csv(Drug_Target_matrix_one2one_New,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drugbank/HCIP_in_DrugBank.csv",quote = F)


###有药理活性的Target
pharmacologically_active_Matrix=matrix(nrow = 1000,ncol = 3)
r=1
for (l in 1:dim(Drug_Target_matrix_one2one_New)[1]) {
  if (Drug_Target_matrix_one2one_New[l,1] %in% pharmacologically_active_drug_Target) {
    pharmacologically_active_Matrix[r,]=Drug_Target_matrix_one2one_New[l,]
    r=r+1
  }
}
pharmacologically_active_Matrix=na.omit(pharmacologically_active_Matrix)

write.csv(pharmacologically_active_Matrix,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Drugbank/pharmacologically_active_Drug.csv",quote = F)



###Pharmacology_Database
Pharmacology_Database=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Pharmacology/approved_drug_primary_target_interactions.csv",stringsAsFactors = F)
length(intersect(Pharmacology_Database[,3],HCIP[,2]))
Pharmacology_targets_and_families=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Pharmacology/targets_and_families.csv",stringsAsFactors = F)
length(intersect(Pharmacology_targets_and_families[,5],HCIP[,2]))
intersect(Pharmacology_targets_and_families[,11],HCIP[,2])

for (k in 1:length(Pharmacology_Database[,3])) {
  r=which(Pharmacology_targets_and_families[,5]==Pharmacology_Database[k,3])
  if(length(r)>0){
    Pharmacology_Database[k,3]=unique(Pharmacology_targets_and_families[r,11])
  }
  else{
    
  }
}

intersect(HCIP[,2],Pharmacology_Database[,3])

###ChEMBL_Database















