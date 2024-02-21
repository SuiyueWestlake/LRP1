HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/HCIP.csv")
Molecules_for_HCIP=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/IPA_annotation_for_MaJiangFigure/Molecules_for_HCIP.csv")
Pathway=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/IPA_annotation_for_MaJiangFigure/Variant_Effects_for_HCIP.csv")
Regulator=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/Postive_Negative_regulator/A combined ex vivo and in vivo RNAi screen for notch regulators in Drosophila reveals an extensive notch interaction network/Regulator_Node_Matrix.csv")
Delta=rbind(HCIP[which(HCIP[,1]=="DLL1"),],HCIP[which(HCIP[,1]=="DLL3"),],HCIP[which(HCIP[,1]=="DLL4"),])
JAG=rbind(HCIP[which(HCIP[,1]=="JAG1"),],HCIP[which(HCIP[,1]=="JAG2"),])
MAML=rbind(HCIP[which(HCIP[,1]=="MAML1"),],HCIP[which(HCIP[,1]=="MAML2"),],HCIP[which(HCIP[,1]=="MAML3"),])
NOTCH=rbind(HCIP[which(HCIP[,1]=="NOTCH1"),],HCIP[which(HCIP[,1]=="NOTCH2"),],HCIP[which(HCIP[,1]=="NOTCH3"),],HCIP[which(HCIP[,1]=="NOTCH4"),])
RBPJ=rbind(HCIP[which(HCIP[,1]=="RBPJ"),])

unique(intersect(Delta[,2],JAG[,2]))
unique(intersect(Delta[,2],NOTCH[,2]))

unique(intersect(JAG[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Cytoplasm"),1]))

intersect(Regulator[which(Regulator[,3]=="DOWN"),2],unique(intersect(JAG[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Cytoplasm"),1])))

intersect(Regulator[which(Regulator[,3]=="UP"),2],unique(intersect(JAG[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Cytoplasm"),1])))

intersect(Regulator[,2],unique(intersect(JAG[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Extracellular Space"),1])))
unique(intersect(JAG[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Extracellular Space"),1]))

unique(intersect(NOTCH[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Plasma Membrane"),1]))
intersect(Regulator[,2],unique(intersect(NOTCH[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Plasma Membrane"),1])))


intersect(Regulator[,2],unique(intersect(JAG[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Plasma Membrane"),1])))


unique(intersect(NOTCH[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Cytoplasm"),1]))

unique(intersect(unique(intersect(NOTCH[,2],RBPJ[,2])),Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Cytoplasm"),1]))
unique(intersect(unique(intersect(NOTCH[,2],RBPJ[,2])),Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Nucleus"),1]))

unique(intersect(RBPJ[,2],MAML[,2]))

intersect(MAML[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Nucleus"),1])

intersect(Regulator[,2],intersect(MAML[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Nucleus"),1]))

intersect(Regulator[,2],intersect(RBPJ[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Nucleus"),1]))

intersect(Regulator[which(Regulator[,3]=="DOWN"),2],intersect(RBPJ[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Nucleus"),1]))

intersect(Regulator[,2],intersect(RBPJ[,2],Molecules_for_HCIP[which(Molecules_for_HCIP[,4]=="Cytoplasm"),1]))



