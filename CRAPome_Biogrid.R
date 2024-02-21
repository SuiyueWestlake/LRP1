### CRAPome and Biogrid Figures
HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv")
MUSE_Result=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/MUSE_Result/MUSE_Result.csv")
#ALL=length(which(HCIP$Label=="T"))
un_fliter=MUSE_Result[which(MUSE_Result$Label=="F"),2]
filter=HCIP[which(HCIP$Label=="F"),2]

C=c(length(un_fliter)/dim(MUSE_Result)[1],length(filter)/dim(HCIP)[1])
barplot(C*100,ylim = c(0,25),space = 0.7)

All_known=length(which(MUSE_Result$Label=="T"))/sum(length(which(MUSE_Result$Label=="U")),length(which(MUSE_Result$Label=="T")))
HCIP_known=length(which(HCIP$Label=="T"))/sum(length(which(HCIP$Label=="U")),length(which(HCIP$Label=="T")))

###
Biogrid=matrix(ncol = 2,nrow = 2)
Biogrid[,1]=c(All_known,1 - All_known)
Biogrid[,2]=c(HCIP_known,1 - HCIP_known)
barplot(Biogrid[1,]*100,ylim = c(0,4))
