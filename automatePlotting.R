#email lindsay olson w/ questions: olsonlindsaya@gmail.com


clusteringData$cluster2 <- as.factor(clusteringData$cluster2)
plotNames = names(clusteringData)
name = c("1", "2")

for(i in 1:14){
  
  mypath <- file.path("/Users/lolson/Documents/001_JDP/001_BDIL/006_Projects/14_ParentalStress/kmeansClustering/2Cluster",paste("boxPlot_", plotNames[i], ".tiff", sep = ""))
  
  tiff(file=mypath)
  #mytitle = paste(plotNames[i])
  myVar = plotNames[i]
  #thisData = clusteringData[i]
  
  tiff(file=mypath,width = 4, height = 3, units = 'in', res = 300)
  
  ggplot(clusteringData, aes(x=cluster2, y=as.matrix(clusteringData[i]), color=cluster2), lwd = 4) +
    geom_boxplot(outlier.shape=NA) +
    theme(text = element_text(size = 20))  +
    scale_color_manual(values=c("green","orange")) +
    scale_fill_manual(values=c("green","orange")) +
    xlab("Cluster") +
    ylab(myVar) +
    coord_cartesian(ylim = c(10,90))
  
  dev.off()
  
  
plotNames = names(clusterMeans3)
name = c("1", "2", "3")
for(i in 2:15){
  
  
  mypath <- file.path("/Users/lolson/Documents/001_JDP/001_BDIL/006_Projects/14_ParentalStress/kmeansClustering/3Cluster",paste("barPlot_", plotNames[i], ".tiff", sep = ""))
  
  tiff(file=mypath)
  mytitle = paste(plotNames[i])
  myVar = plotNames[i]
  thisData = clusterMeans[i]
  
  
  tiff(file=mypath,width = 4, height = 3, units = 'in', res = 300)
  barplot(as.matrix(clusterMeans3[i]), main=mytitle,
          ylim = c(0,70),
          xlab=mytitle, beside=TRUE, col=coul,
          names.arg = name, cex.axis=1.5, cex.names=1.5, cex.lab=1.5, cex.main=1.5)
  dev.off()
}

