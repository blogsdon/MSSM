###get data
require(synapseClient)
synapseLogin()

require(data.table)
require(dplyr)

#rnaseq
rnaseqObj <- synGet('syn4921702')
expr <- fread(rnaseqObj@filePath,data.table=F)


#covariates
covariatesObj <- synGet('syn4921703')
covariates <- fread(covariatesObj@filePath,data.table=F)

#break into three unique tissue types
#TISSUE=Brain regions (BM10=Frontal Pole; BM22=Superior Temporal Gyrus; BM36=Parahippocampal Gyrus)

#frontal pole
covFP <- filter(covariates,TISSUE=='BM_10')
covSTG <- filter(covariates,TISSUE=='BM_22')
covPHG <- filter(covariates,TISSUE=='BM_36')

###merge data

expr2 <- t(expr)
colnames(expr2) <- expr2[1,]
expr2 <- cbind(rownames(expr2),expr2)
colnames(expr2)[1] <- 'sampleId'
gc()

fpData <- merge(covFP,expr2,by.x = "Sample.ID", by.y = "sampleId" )
row.names(fpData) <- fpData$Sample.ID
stgData <- merge(covSTG,expr2,by.x = "Sample.ID", by.y = "sampleId")
row.names(stgData) <- stgData$Sample.ID
phgData <- merge(covPHG,expr2,by.x = "Sample.ID", by.y = "sampleId")
row.names(phgData) <- phgData$Sample.ID

###write files with cdr cutpoint
fpDataControl <- filter(fpData,CDR %in% c('0','0.5','1'))
fpDataCase <- filter(fpData,CDR %in% c('2','3','4','5'))

stgDataControl <- filter(stgData,CDR %in% c('0','0.5','1'))
stgDataCase <- filter(stgData,CDR %in% c('2','3','4','5'))

phgDataControl <- filter(phgData,CDR %in% c('0','0.5','1'))
phgDataCase <- filter(phgData,CDR %in% c('2','3','4','5'))


write.csv(fpDataCase %>% select(starts_with("ENSG")),file='fpCase.csv',quote = F)
write.csv(fpDataControl %>% select(starts_with("ENSG")),file='fpControl.csv',quote = F)
write.csv(stgDataCase %>% select(starts_with("ENSG")),file='stgCase.csv',quote = F)
write.csv(stgDataControl %>% select(starts_with("ENSG")),file='stgControl.csv',quote = F)
write.csv(phgDataCase %>% select(starts_with("ENSG")),file='phgCase.csv',quote = F)
write.csv(phgDataControl %>% select(starts_with("ENSG")),file='phgControl.csv',quote = F)


