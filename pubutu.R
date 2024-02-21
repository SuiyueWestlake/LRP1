install.packages("data.table")
library("data.table")
vr=Mut_Overlap[,c(10,15,1)]
colnames(vr)=c("Gene","Type","Patient")
vr=data.table(vr)

my_heatmap <- function(vr, pal = c("#F2F2F2",colorRampPalette(c("blue", "white", "red"))(5)[c(1,2)],"#F2F2F2",colorRampPalette(c("blue", "white", "red"))(5)[c(4,5)],brewer.pal(n = 8, name ="Accent")[c(1,4,6,8,2,3,5,7)],"#E31A1C","#6A3D9A"),type = c("DEL","LOSS","NEUTRAL","GAIN","AMPL","nonsynonymous SNV","synonymous SNV","intronic","stopgain","nonframeshift deletion","splicing", "frameshift deletion","UTR3","frameshift insertion","UTR5"),order_gene = T, order_patient = T, hist_plot = T, legend_dist = 0.4, col_text_cex = 1, row_text_cex = 1, sub_gene= NULL,heatmap_mar = c(5,17,1,2), heatmap_oma=c(0.2,0.2,0.2,0.2),heatmap_mex=0.5, legend_mar = c(1,0,4,1),xlab_adj=1, order_omit=c("NEUTRAL"), annotation_col=NULL, annotation_colors = NULL, heatmap_height = 3, heatmap_width = 3, anno_height=NULL)
{
  if((length(pal) - length(type)) !=1 ){stop("Pal must be one longer than type, because first one pal is col for no mutation")}
  if(!is.null(sub_gene)){
    pal_dt <- data.table(pal, type=c("NoMut",type))
    vr <- vr[Gene %in% sub_gene,]
    type <- pal_dt[type %in% unique(vr$Type),type]
    pal <- c(pal[1],pal_dt[type, on="type"][,pal])
  }else{
    pal_dt <- data.table(pal, type=c("NoMut",type))
    type <- pal_dt[type %in% unique(vr$Type),type]
    pal <- c(pal[1],pal_dt[type, on="type"][,pal])
  }
  dt <- unique(vr[,.(Gene,Type,Patient)])
  dt$Type <- factor(dt$Type, levels = type)
  if(order_gene){gene <- dt[!Type %in% order_omit,.(N=length(unique(Patient))),by=Gene][order(N),Gene]}else{gene <- unique(dt[!Type %in% order_omit, Gene])}
  dt$Gene <- factor(dt$Gene, levels = gene)
  if(order_patient){patient <- data.table(table(vr[!Type %in% order_omit,]$Patient))[order(-N),V1]}else{patient <- unique(dt[!Type %in% order_omit, Patient])}
  dt$Patient <- factor(dt$Patient, levels = c(patient, setdiff(unique(dt$Patient),patient)))
  
  setkey(dt, "Type")
  
  n <- length(unique(dt$Type))
  
  dt$Gene_Patients <- paste(dt$Gene, dt$Patient)
  dt_inf <- dt[,.N,by=.(Gene, Patient)]
  max_mut_num <- max(dt_inf$N)
  dt[,Mut_num:=seq_len(.N),by=.(Patient,Gene)]
  #main plot
  
  dt1 <- copy(dt)
  dt1[Mut_num !=1, Type:=NA]
  dc <- data.frame(dcast(dt1, Patient ~ Gene, value.var = "Type", fun.aggregate = function(x)(x[!is.na(x)][1])))
  rownames(dc)<- dc[,1]
  data_matrix<-data.matrix(dc[,-1])
  data_matrix[is.na(data_matrix)] <- 0
  pal=pal
  breaks<-seq(-1,10,1)
  if(!hist_plot & is.null(annotation_col)){
    layout(matrix(data=c(1,2), nrow=1, ncol=2), widths=c(8,2), heights=c(1,1))
    par(mar=heatmap_mar, oma=heatmap_oma, mex=heatmap_mex)
  }else if(hist_plot & is.null(annotation_col)){
    layout(matrix(c(2,4,1,3),2,2,byrow=TRUE), widths=c(heatmap_width,1), 
           heights=c(1,heatmap_height), TRUE)
    par(mar=heatmap_mar)
  }else if(hist_plot & !is.null(annotation_col)){
    if(is.null(anno_height)){anno_height <- 0.02 * ncol(annotation_col)}
    layout(matrix(data=c(3,5,2,5,1,4), nrow=3, ncol=2, byrow=TRUE), widths=c(heatmap_width,1), heights=c(1, anno_height, heatmap_height))
    par(mar=heatmap_mar, oma=heatmap_oma, mex=heatmap_mex)
  }else if(!hist_plot & !is.null(annotation_col)){
    if(is.null(anno_height)){anno_height <- 0.02 * ncol(annotation_col)}
    layout(matrix(data=c(2,4,1,3), nrow=2, ncol=2, byrow=TRUE), widths=c(8,2), heights=c(anno_height,1))
    par(mar=heatmap_mar, oma=heatmap_oma, mex=heatmap_mex)
  }
  
  
  
  
  image(x=1:nrow(data_matrix),y=1:ncol(data_matrix),
        z=data_matrix,xlab="",ylab="",breaks=breaks,
        col=pal[1:11],axes=FALSE)
  
  
  #sub plot
  add_plot <- function(dt, i){
    dt1 <- copy(dt)
    dt1[Mut_num != i, Type:=NA]
    dc <- data.frame(dcast(dt1, Patient ~ Gene, value.var = "Type", fun.aggregate = function(x){ifelse(length(x) >1,x[!is.na(x)][1],factor(NA))}))
    rownames(dc)<- dc[,1]
    data_matrix <- data.matrix(dc[,-1])
    xy <- which(data_matrix !=0, arr.ind = T)
    #apply(xy, 1, function(x)points(x[1], x[2],pch=15, cex=2.5 -0.5*i, col=pal[data_matrix[x[1],x[2]]+1]))
    apply(xy, 1, function(x)points(x[1]-0.6+i*0.25, x[2],pch=15, cex=1.2 - i*0.08, col=pal[data_matrix[x[1],x[2]]+1]))
  }
  
  ploti <- data.frame(i=2:max_mut_num)
  apply(ploti, 1, function(i){print(add_plot(dt, i))})
  
  text(x=1:nrow(data_matrix)+0.1, y=par("usr")[1] - xlab_adj, 
       srt = 90, adj = 0.5, labels = rownames(data_matrix), 
       xpd = TRUE, cex=col_text_cex)
  axis(2,at=1:ncol(data_matrix),labels=colnames(data_matrix),
       col="white",las=1, cex.lab=0.1, cex.axis=row_text_cex)
  abline(h=c(1:ncol(data_matrix))+0.5,v=c(1:nrow(data_matrix))+0.5,
         col="white",lwd=2,xpd=F)
  #add annotation plot
  if(!is.null(annotation_col)){
    change_factor <- function(x){as.numeric(factor(x, labels = 1:length(levels(x))))} #change infomation to numeric       
    colname_tmp <- colnames(annotation_col)
    annotation_col_mt <- as.matrix(apply(annotation_col, 2, change_factor))
    rownames(annotation_col_mt) <- rownames(annotation_col)
    colnames(annotation_col_mt) <- colname_tmp
    annotation_col_mt <- annotation_col_mt[rownames(data_matrix),]
    ## change infomation numric to unique number  
    cumsum <- 0
    if(!is.null(dim(annotation_col_mt))){#if more than one column, cummulate info numeric
      for(i in 1:ncol(as.data.frame(annotation_col_mt))){
        annotation_col_mt[,i] <- cumsum + annotation_col_mt[,i]
        cumsum <- max(annotation_col_mt[,i])
      }
    }
    ## get color according to infomation
    get_color <- function(anno){return(annotation_colors[[anno]][levels(annotation_col[,anno])])}
    palAnn <- NULL
    if(is.null(dim(annotation_col_mt))){
      rowname_tmp <- rownames(annotation_col_mt)
      annotation_col_mt <- as.matrix(annotation_col_mt, nrow=1)
      rownames(annotation_col_mt) <- rowname_tmp
      colnames(annotation_col_mt) <- colname_tmp
    }
    for(anno in colnames(annotation_col_mt)){
      palAnn <- c(palAnn, get_color(anno))
    }
    par(mar=c(0,heatmap_mar[2], 0,  heatmap_mar[4]))
    image(x=1:nrow(annotation_col_mt), y=1:ncol(annotation_col_mt), z= annotation_col_mt, col=palAnn, xlab="",ylab="",
          axes=FALSE)
    axis(2,at=1:ncol(annotation_col_mt),labels=colnames(annotation_col_mt),
         col="white",las=1, cex.lab=0.1, cex.axis=row_text_cex)
    abline(h=c(1:ncol(annotation_col_mt))+0.5,v=c(1:nrow(annotation_col_mt))+0.5,
           col="white",lwd=2,xpd=F)
  }
  if(hist_plot){
    #hist
    par(mar=c(0,4+0.5,3,heatmap_mar[4]-1))
    patient_dt <- dt[,.N,by=.(Patient,Type)]
    mt <- data.frame(dcast(patient_dt, Type ~ Patient, value.var = "N"))
    data_matrix <- data.matrix(mt[,-1])
    rownames(data_matrix) <- mt[,1]
    tryCatch(data_matrix <- data_matrix[setdiff(type, order_omit), patient], error = function(e){print("type argument or your patient name format(include "-" and so on )")})
    data_matrix[is.na(data_matrix)] <- 0
    omit_idx <- NULL
    for(i in order_omit){omit_idx <- c(omit_idx,1+which(type == i))}
    barplot(data_matrix, col=pal[-c(1,omit_idx)],space=0,border = "white",axes=T,xlab="",ann=F, xaxt="n")
    
    par(mar=c(heatmap_mar[1]-2 , 0.8, heatmap_mar[3]+2.2, 3),las=1)
    gene_dt <- dt[,.N,by=.(Gene,Type)]
    mt <- data.frame(dcast(gene_dt, Type ~ Gene, value.var = "N"))
    data_matrix <- data.matrix(mt[,-1])
    rownames(data_matrix) <- mt[,1]
    gene <- gsub("ATM,", "ATM.", gene)
    tryCatch(data_matrix <- data_matrix[setdiff(type, order_omit), gene], error = function(e){print("type argument or check your gene name format(please not include "-" and so on)")})
    data_matrix[is.na(data_matrix)] <- 0
    barplot(data_matrix, col=pal[-c(1,omit_idx)],space=0,border = "white",axes=T,xlab="", ann=F, horiz = T, yaxt="n")
    
  }
  
  #add legend   
  par(mar=legend_mar)
  plot(3, 8,  axes=F, ann=F, type="n")
  if(is.null(annotation_col)){
    ploti <- data.frame(i=1:length(type))
  }else{
    #add annotation legend
    ploti <- data.frame(i=1:(length(type) + max(annotation_col_mt)))
    pal <- c("NULL", palAnn, pal[-1])
    anno_label <- NULL
    for (anno in colnames(annotation_col)){
      anno_label <- c(anno_label, levels(annotation_col[[anno]]))
    }
    type <- c(anno_label,type)
  }
  if(!hist_plot){
    tmp <- apply(ploti, 1, function(i){print(points(2, 10+(length(type)-i)*legend_dist, pch=15, cex=2, col=pal[i+1]))})
    tmp <- apply(ploti, 1, function(i){print(text(3, 10+(length(type)-i)*legend_dist, labels = type[i],pch=15, cex=1, col="black"))})
  }
  if(hist_plot){
    tmp <- apply(ploti, 1, function(i){print(points(2, 5+(length(type)-i)*legend_dist, pch=15, cex=0.9, col=pal[i+1]))})
    tmp <- apply(ploti, 1, function(i){print(text(2.8, 5+(length(type)-i)*legend_dist, labels = type[i],pch=15, cex=0.9, col="black"))})  
  }
  
}
install.packages("RColorBrewer")
library("RColorBrewer")




pubutu=my_heatmap(vr, pal = c("#F2F2F2","#3270C0","#C25B56"), 
           type = c("Tolerated","Damaging"),
           order_gene = T, order_patient = T, hist_plot = T, 
           legend_dist = 0.4, col_text_cex = 0.8, row_text_cex = 1, sub_gene= NULL,
           heatmap_mar = c(5,5,1,2), heatmap_oma=c(0.2,0.2,0.2,1),heatmap_mex=0.5, 
           legend_mar = c(1,0,4,1),xlab_adj=1, order_omit=c("NEUTRAL"), 
           annotation_col=NULL, annotation_colors = NULL, heatmap_height = 6, heatmap_width = 16, anno_height=NULL)
pubutu




###PSM柱状图
Protein=c("NOTCH1","FBXW7","JAK1","CHD4","EZH2","NOTCH3","SUZ12","KMT2C",
          "TDP1","GATA3","NOTCH2","LRP1","NFIC","AKAP1","LAGE3","SATB1","CHD7")
Data_for_PSM=HCIP[which(HCIP[,2] %in% Protein),]
Sum_PSM=data.frame(ncol = 2,nrow = length(Protein))
for (i in 1:length(Protein)) {
  Sum_PSM[i,1]=Protein[i]
  Sum_PSM[i,2]=sum(Data_for_PSM[which(Data_for_PSM$Prey==Protein[i]),6])+sum(Data_for_PSM[which(Data_for_PSM$Prey==Protein[i]),7])
}

colnames(Sum_PSM)=c("Protein","PSM") #加表头
Sum_PSM[,2]=log(Sum_PSM[,2])

barplot(rev(Sum_PSM$PSM),horiz=T)



