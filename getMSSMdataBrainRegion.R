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


