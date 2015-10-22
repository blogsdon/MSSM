###get data
require(synapseClient)
synapseLogin()

require(data.table)
require(dplyr)

#rnaseq
rnaseqObj <- synGet('syn4921702')
expr <- fread(rnaseqObj@filePath,data.table=F,stringsAsFactors = F)


#covariates
covariatesObj <- synGet('syn4921703')
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

write.csv(dataMat$fpDataCase,file='AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_FP_CDR_2_5.sex_race_age_RIN_PMI_batch_site.corrected.csv',quote = F)
write.csv(dataMat$fpDataControl,file='AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_FP_CDR_0_1.sex_race_age_RIN_PMI_batch_site.corrected.csv',quote = F)
write.csv(dataMat$stgDataCase,file='AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_STG_CDR_2_5.sex_race_age_RIN_PMI_batch_site.corrected.csv',quote = F)
write.csv(dataMat$stgDataControl,file='AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_STG_CDR_0_1.sex_race_age_RIN_PMI_batch_site.corrected.csv',quote = F)
write.csv(dataMat$phgDataCase,file='AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_PHG_CDR_2_5.sex_race_age_RIN_PMI_batch_site.corrected.csv',quote = F)
write.csv(dataMat$phgDataControl,file='AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_PHG_CDR_0_1.sex_race_age_RIN_PMI_batch_site.corrected.csv',quote = F)


foo <- File('AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_FP_CDR_0_1.sex_race_age_RIN_PMI_batch_site.corrected.csv',parentId='syn5004871')
foo <- synStore(foo)

foo <- File('AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_FP_CDR_2_5.sex_race_age_RIN_PMI_batch_site.corrected.csv',parentId='syn5004871')
foo <- synStore(foo)

foo <- File('AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_STG_CDR_0_1.sex_race_age_RIN_PMI_batch_site.corrected.csv',parentId='syn5004871')
foo <- synStore(foo)

foo <- File('AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_STG_CDR_2_5.sex_race_age_RIN_PMI_batch_site.corrected.csv',parentId='syn5004871')
foo <- synStore(foo)

foo <- File('AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_PHG_CDR_0_1.sex_race_age_RIN_PMI_batch_site.corrected.csv',parentId='syn5004871')
foo <- synStore(foo)

foo <- File('AMP-AD_MSBB_MSSM_IlluminaHiSeq2500_normalized_PHG_CDR_2_5.sex_race_age_RIN_PMI_batch_site.corrected.csv',parentId='syn5004871')
foo <- synStore(foo)
