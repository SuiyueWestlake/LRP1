###New Subcellular location
Location=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Notch/Data/Notch原始数据/Result/Subcellular_Location/Protein_Location_results.csv",stringsAsFactors = F)
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv",stringsAsFactors = F)
HCIP_Location=Location[which(Location$Gene %in% HCIP[,2]),]
HCIP_Location=HCIP_Location[,c(2,35)]
HCIP_Location_Vector=unlist(strsplit(HCIP_Location[,2],split = ";"))
HCIP_Location_Matrix=data.frame(table(HCIP_Location_Vector))
HCIP_Location_Matrix[,1]=as.character(HCIP_Location_Matrix[,1])
for (i in 1:dim(HCIP_Location_Matrix)[1]) {
  if(HCIP_Location_Matrix[i,2]<10){
    HCIP_Location_Matrix[i,1]<-"Other_Location"
  }
  
}

Matrix_for_Plot=HCIP_Location_Matrix[which(HCIP_Location_Matrix[,1]!="Other_Location"),]
Matrix_for_Plot[13,]=c("Others",sum(HCIP_Location_Matrix[which(HCIP_Location_Matrix$HCIP_Location_Vector=="Other_Location"),2]))
Matrix_for_Plot[,2]=as.numeric(Matrix_for_Plot[,2])
M=data.frame(nrow=13,ncol=2)
M[1:12,]=Matrix_for_Plot[order(Matrix_for_Plot$Freq[1:12],decreasing = T),]
M[13,]=Matrix_for_Plot[13,]
mycolor<-c("#BEBADA","#B3CDE3","#A6CEE3","#80B1D3","#F7FCF0","#E0F3DB","#CCEBC5","#7BCCC4","#8DD3C7","#4EB3D3","#2B8CBE","#0868AC","#084081")
par(mfcol=c(1,1)) 
pie(M[,2],labels=NA,clockwise=T,col = mycolor[c(13,12,11,10,9,8,7,6,5,4,3,2,1)],main = "Subcellular Localizations")
legend("right",c(M[,1]),fill=mycolor[c(13,12,11,10,9,8,7,6,5,4,3,2,1)])
#brewer.pal(1,"Greys"),brewer.pal(1,"YlGn"),brewer.pal(1,"RdPu"),brewer.pal(1,"Purples"),brewer.pal(1,"OrRd"),
