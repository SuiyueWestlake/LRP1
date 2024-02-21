Association=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Disease pathway and protein interaction data/bio-pathways-associations.csv",as.is = T)
DiseaseClass=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Disease pathway and protein interaction data/bio-pathways-diseaseclasses.csv",as.is = T)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("clusterProfiler")
library("clusterProfiler")
library(org.Hs.eg.db)

HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv",as.is = T)
HCIP_Symbol=unique(HCIP[,2])
Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")

HCIP_EntrezID <- bitr(HCIP_Symbol, fromType = "SYMBOL", #fromType是指你的数据ID类型是属于哪一类的
                toType = c("ENTREZID"), #toType是指你要转换成哪种ID类型，可以写多种，也可以只写一种
                OrgDb = org.Hs.eg.db)#Orgdb是指对应的注释包是哪个

HCIP_Disease_Matrix=matrix(ncol = 2,nrow=5000)
k=1
for (i in 1:dim(Association)[1]) {
  GeneID_of_the_disease=unlist(strsplit(Association[i,3],","))
  HCIP_of_the_disease=intersect(GeneID_of_the_disease,HCIP_EntrezID[,2])
  if(length(HCIP_of_the_disease)>0){
    for (j in HCIP_of_the_disease) {
      HCIP_Disease_Matrix[k,1]=Association[i,2]
      HCIP_Disease_Matrix[k,2]=j
      k=k+1
    }
  }
}


CC=c()
for (i in 1:dim(Association)[1]){
  C=unlist(strsplit(Association[i,3],","))
  CC=c(CC,C)
}








