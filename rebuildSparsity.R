#rebuild sparsity files



generateSparsity <- function(method,brainRegion,diseaseState){
  require(metanetwork)
  str <- paste0('aws s3 cp s3://metanetworks/MSSM/',brainRegion,'/',diseaseState,'/',method,' ./')
  system(str)
  load(method)
  outputpath='./'
  method2 <- strsplit(strsplit(method,'result_')[[1]][2],'\\.rda')[[1]][1]
  cat(method2,'\n')
  if(method2=='sparrowZ'){
    network2 <- applySparrowBonferroni(network)
    cat(paste('sparrow1Bonferroni',sum(network2!=0)/2,sep=','),'\n',file=paste0(outputpath,'sparsity.csv'),sep='',append=TRUE)
    rm(network2)
    gc()
    network2 <- applySparrowFDR(network)
    cat(paste('sparrow1FDR',sum(network2!=0)/2,sep=','),'\n',file=paste0(outputpath,'sparsity.csv'),sep='',append=TRUE)
    rm(network2)
    gc()
  }else if(method2=='sparrow2Z'){
    network2 <- applySparrowBonferroni(network)
    cat(paste('sparrow2Bonferroni',sum(network2!=0)/2,sep=','),'\n',file=paste0(outputpath,'sparsity.csv'),sep='',append=TRUE)
    rm(network2)
    gc()
    network2 <- applySparrowFDR(network)
    cat(paste('sparrow2FDR',sum(network2!=0)/2,sep=','),'\n',file=paste0(outputpath,'sparsity.csv'),sep='',append=TRUE)
    rm(network2)
    gc()    
  }else{
    cat(paste(method2,sum((network+t(network))!=0)/2,sep=','),'\n',file=paste0(outputpath,'sparsity.csv'),sep='',append=TRUE)
    rm(network)
    gc()
  }
}


method_list <- scan('methods.txt',what='character')
brainRegion <- c('FP','FP','STG','STG','PHG','PHG')
diseaseState <- c('CDR0_1','CDR2_5','CDR0_1','CDR2_5','CDR0_1','CDR2_5')
for (i in 1:6){
  sapply(method_list,generateSparsity,brainRegion[i],diseaseState[i])
  str2 <- paste0('aws s3 mv ./sparsity.csv s3://metanetworks/MSSM/',brainRegion[i],'/',diseaseState[i],'/')
  cat(str2,'\n')
  system(str2)
  system('rm')
}
