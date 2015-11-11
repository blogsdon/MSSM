#!/bin/bash

Rscript ../metanetworkSynapse/pushConsensus.R "methods.txt" "s3://metanetworks/MSSM/FP/"
Rscript ../metanetworkSynapse/pushConsensus.R "methods.txt" "s3://metanetworks/MSSM/STG/"
Rscript ../metanetworkSynapse/pushConsensus.R "methods.txt" "s3://metanetworks/MSSM/PHG/"

echo "syn4921703" > synMSSM.txt
echo "syn4921702" >> synMSSM.txt

echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMBrainRegion.sh" > codeMSSM.txt
echo "https://github.com/blogsdon/MSSM/blob/master/pushMSSMnetwork.sh" >> codeMSSM.txt

aws s3 cp s3://metanetworks/MSSM/FP/result_rankConsensus.rda ./
aws s3 cp s3://metanetworks/MSSM/FP/sparsity.csv ./
../metanetworkSynapse/pushNet.sh -a "syn5016946" -b "codeMSSM.txt" -c "synMSSM.txt" -z -r "None" -s "HomoSapiens" -t "ALL" -u "FP" -x "../metanetworkSynapse/pushSparseNetworkSynapse.R"

aws s3 cp s3://metanetworks/MSSM/STG/result_rankConsensus.rda ./
aws s3 cp s3://metanetworks/MSSM/STG/sparsity.csv ./
../metanetworkSynapse/pushNet.sh -a "syn5016945" -b "codeMSSM.txt" -c "synMSSM.txt" -z -r "None" -s "HomoSapiens" -t "ALL" -u "STG" -x "../metanetworkSynapse/pushSparseNetworkSynapse.R"

aws s3 cp s3://metanetworks/MSSM/PHG/result_rankConsensus.rda ./
aws s3 cp s3://metanetworks/MSSM/PHG/sparsity.csv ./
../metanetworkSynapse/pushNet.sh -a "syn5016944" -b "codeMSSM.txt" -c "synMSSM.txt" -z -r "None" -s "HomoSapiens" -t "ALL" -u "PHG" -x "../metanetworkSynapse/pushSparseNetworkSynapse.R"
