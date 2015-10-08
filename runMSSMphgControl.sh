#!/bin/bash

rm codePhgControl.txt
rm synPhgControl.txt

#./grabCMCdata.sh

echo "syn4921702" >> synPhgControl.txt
echo "syn4921703" >> synPhgControl.txt

echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMphgControl.sh" >> codePhgControl.txt

cd /shared/metanetworkSynapse/
qsub -v s3="s3://metanetworks/MSSM/PHG/CDR0_1/",dataFile="/shared/MSSM/phgControl.csv",pathv="/shared/metanetworkSynapse/",sparrowZ=1,sparrow2Z=1,lassoCV1se=1,lassoCVmin=1,lassoAIC=1,lassoBIC=1,ridgeCV1se=1,ridgeCVmin=1,ridgeAIC=1,ridgeBIC=1,genie3=1,tigressRootN=1,elasticNetAIC=1,elasticNetBIC=1,elasticNetCVmin=1,elasticNetCV1se=1,numberCore=319,outputpath="/shared/MSSM/PHG/CDR0_1/" -pe orte 319 buildNet.sh
#qsub -v s3="s3://metanetworks/MSSM/PHG/CDR0_1/",dataFile="/shared/MSSM/phgControl.csv",pathv="/shared/metanetworkSynapse/",ridgeCV1se=1,ridgeCVmin=1,ridgeAIC=1,genie3=1,tigressRootN=1,elasticNetAIC=1,elasticNetBIC=1,elasticNetCVmin=1,elasticNetCV1se=1,numberCore=319,outputpath="/shared/MSSM/PHG/CDR0_1/" -pe orte 319 buildNet.sh