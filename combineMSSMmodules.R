#combine all MSSM modules into a single file

require(synapseClient)
synapseLogin()

#BM10: FP, BM22: STG, BM36: PHG

semssm10 <- synGet('syn5305001')
semssm22 <- synGet('syn5305000')
semssm36 <- synGet('syn5304999')

seFp <- read.csv(semssm10@filePath,stringsAsFactors = F,header=F)
seStg <- read.csv(semssm22@filePath,stringsAsFactors = F,header=F)
sePhg <- read.csv(semssm36@filePath,stringsAsFactors = F,header=F)

metanetworkObj <- synGet('syn5298224')

mnAll <- read.csv(metanetworkObj@filePath,stringsAsFactors = F,header=T)

megmssm10 <- synGet('syn5004917')
megmssm22 <- synGet('syn5004919')
megmssm36 <- synGet('syn5004921')


require(dplyr)
mgFp <- readLines(megmssm10@filePath) %>% strsplit(split='\t')
mgStg <- readLines(megmssm22@filePath) %>% strsplit(split='\t')
mgPhg <- readLines(megmssm36@filePath) %>% strsplit(split='\t')

internal <- function(x,y){
  #x gene list with first element as module name
  nl <- length(x) -1
  mat <- cbind(x[-1],rep(x[1],nl))
  colnames(mat) <- c('hgncName',y)
  return(mat)
}
mgFpTemp <- lapply(mgFp,internal,'megenaModuleFP')
mgFpDf <- do.call(rbind,mgFpTemp) %>% data.frame

mgStgTemp <- lapply(mgStg,internal,'megenaModuleSTG')
mgStgDf <- do.call(rbind,mgStgTemp) %>% data.frame

mgPhgTemp <- lapply(mgPhg,internal,'megenaModulePHG')
mgPhgDf <- do.call(rbind,mgPhgTemp) %>% data.frame



wgmssmfp <- synGet('syn5320938')
wgmssmstg <- synGet('syn5320941')
wgmssmphg <- synGet('syn5320936')


wgFp <- read.csv(wgmssmfp@filePath,stringsAsFactors = F,header=F)
wgStg <- read.csv(wgmssmstg@filePath,stringsAsFactors = F,header=F)
wgPhg <- read.csv(wgmssmphg@filePath,stringsAsFactors = F,header=F)

colnames(wgFp) <- c('geneName','hgncName','wgcnaModuleFP')
colnames(wgStg) <- c('geneName','hgncName','wgcnaModuleSTG')
colnames(wgPhg) <- c('geneName','hgncName','wgcnaModulePHG')

###finish merging
colnames(seFp) <- c('geneName','hgncName','speakeasyModuleFP')
colnames(seStg) <- c('geneName','hgncName','speakeasyModuleSTG')
colnames(sePhg) <- c('geneName','hgncName','speakeasyModulePHG')

masterTable <- merge(mnAll[,-1],seFp,by='geneName')
masterTable <- masterTable[,c(1,5,2:4,6)]
masterTable <- merge(masterTable,seStg[,c(1,3)],by='geneName')
masterTable <- merge(masterTable,sePhg[,c(1,3)],by='geneName')
masterTable <- merge(masterTable,wgFp[,c(1,3)],by='geneName')
masterTable <- merge(masterTable,wgStg[,c(1,3)],by='geneName')
masterTable <- merge(masterTable,wgPhg[,c(1,3)],by='geneName')

masterTable <- merge(masterTable,mgFpDf,by='hgncName')
masterTable <- merge(masterTable,mgStgDf,by='hgncName')
masterTable <- merge(masterTable,mgPhgDf,by='hgncName')
masterTable[,c(1,2)] <- masterTable[,c(2,1)]
write.csv(masterTable,'MSSM_metanetwork_megena_speakeasy_wgcna_modules.csv',quote=F,)
