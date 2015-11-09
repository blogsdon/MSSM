###get data
require(synapseClient)
synapseLogin()

require(data.table)
require(dplyr)

#rnaseq
rnaseqObj <- synGet('syn4921702',downloadLocation='./')
expr <- fread(rnaseqObj@filePath,data.table=F,stringsAsFactors = F)


#covariates
covariatesObj <- synGet('syn4921703',downloadLocation = './')
covariates <- fread(covariatesObj@filePath,data.table=F, stringsAsFactors = F)

#break into three unique tissue types
#TISSUE=Brain regions (BM10=Frontal Pole; BM22=Superior Temporal Gyrus; BM36=Parahippocampal Gyrus)

#frontal pole
covFP <- dplyr::filter(covariates,TISSUE=='BM_10')
covSTG <- dplyr::filter(covariates,TISSUE=='BM_22')
covPHG <- dplyr::filter(covariates,TISSUE=='BM_36')

###merge data

expr2 <- t(expr)
colnames(expr2) <- expr2[1,]
expr2 <- cbind(rownames(expr2),expr2)
colnames(expr2)[1] <- 'sampleId'
gc()

fpData <- merge(covFP,expr2,by.x = "Sample.ID", by.y = "sampleId")
stgData <- merge(covSTG,expr2,by.x = "Sample.ID", by.y = "sampleId")
phgData <- merge(covPHG,expr2,by.x = "Sample.ID", by.y = "sampleId")

gc()
rownames(fpData) <- fpData$Sample.ID
rownames(stgData) <- stgData$Sample.ID
rownames(phgData) <- phgData$Sample.ID

write.csv(fpData[,-c(1:10)],file='fpMSSMrna.csv',quote=F)
write.csv(stgData[,-c(1:10)],file='stgMSSMrna.csv',quote=F)
write.csv(phgData[,-c(1:10)],file='phgMSSMrna.csv',quote=F)


dataMat <- list()
require(dplyr)
###write files with cdr cutpoint
dataMat$fpDataControl <- dplyr::filter(fpData,CDR %in% c('0','0.5','1'))
rownames(dataMat$fpDataControl) <- dataMat$fpDataControl$Sample.ID
dataMat$fpDataCase <- dplyr::filter(fpData,CDR %in% c('2','3','4','5'))
rownames(dataMat$fpDataCase) <- dataMat$fpDataCase$Sample.ID

dataMat$stgDataControl <- dplyr::filter(stgData,CDR %in% c('0','0.5','1'))
rownames(dataMat$stgDataControl) <- dataMat$stgDataControl$Sample.ID
dataMat$stgDataCase <- dplyr::filter(stgData,CDR %in% c('2','3','4','5'))
rownames(dataMat$stgDataCase) <- dataMat$stgDataCase$Sample.ID

dataMat$phgDataControl <- dplyr::filter(phgData,CDR %in% c('0','0.5','1'))
rownames(dataMat$phgDataControl) <- dataMat$phgDataControl$Sample.ID
dataMat$phgDataCase <- dplyr::filter(phgData,CDR %in% c('2','3','4','5'))
rownames(dataMat$phgDataCase) <- dataMat$phgDataCase$Sample.ID


dataMat <- lapply(dataMat,function(x) { return(dplyr::select(x,starts_with("ENSG")))})
dataMat <- lapply(dataMat,as.matrix)
dataMat <- lapply(dataMat,function(x){return(apply(x,2,as.numeric))})
dataMat <- lapply(dataMat,scale)

write.csv(dataMat$fpDataCase ,file='fpCase.csv',quote = F)
write.csv(dataMat$fpDataControl,file='fpControl.csv',quote = F)
write.csv(dataMat$stgDataCase,file='stgCase.csv',quote = F)
write.csv(dataMat$stgDataControl,file='stgControl.csv',quote = F)
write.csv(dataMat$phgDataCase,file='phgCase.csv',quote = F)
write.csv(dataMat$phgDataControl,file='phgControl.csv',quote = F)


