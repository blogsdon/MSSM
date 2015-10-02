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
