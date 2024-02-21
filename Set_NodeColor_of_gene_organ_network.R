gene_organ=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/DDG2P/gene_organ.csv")
colnames(gene_organ)=c("name","type")
NetworkAnalysisResult=read.csv("/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/DDG2P/AnalysisNetworkResult.csv")
NetworkAnalysisResult=NetworkAnalysisResult[,c(6,10)]
Node=merge(gene_organ, NetworkAnalysisResult, by = c("name"), all = T)
ColorLabel=vector(mode="numeric",length=146)
Node=cbind(Node,ColorLabel)
Bait_Name=c("NOTCH1","MAML3","NOTCH4","NOTCH2","RBPJ","NOTCH3","JAG1","MAML2","DLL1","DLL3","JAG2","DLL4","MAML1")

for (i in 1:length(Node[,1])) {
  if(Node[i,3]>10){
    Node[i,4]="D>10"
  }
  if(Node[i,3]<=10){
    Node[i,4]="D=(5,10]"
  }
  if(Node[i,3]<=5){
    Node[i,4]="D=[3,5]"
  }
  if(Node[i,3]<=2){
    Node[i,4]="D<=2"
  }
  if(Node[i,2]=="organ"){
    Node[i,4]="organ"
  }
  if(Node[i,1] %in% Bait_Name){
    Node[i,4]="Bait"
  }
}
write.csv(Node,"/Users/tangsuiyue/Documents/Documents/Project/Final_NOTCH/Data/DDG2P/Node.csv")


