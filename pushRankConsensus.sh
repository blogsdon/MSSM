#!/bin/bash

#push all rank consensus networks to Synapse
#FP CONTROL
echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMfpControl.sh" > codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/generateConsensusNetworks.sh" >> codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/pushRankConsensus.sh" >> codeFile.txt

echo "syn4921702" > synFile.txt
echo "syn4921703" >> synFile.txt

aws s3 cp s3://metanetworks/MSSM/FP/CDR0_1/result_rankConsensus.rda /shared/MSSM/
aws s3 cp s3://metanetworks/MSSM/FP/CDR0_1/sparsity.csv /shared/MSSM/
/shared/metanetworkSynapse/pushNet.sh -a "syn5016947" -b "/shared/MSSM/codeFile.txt" -c "/shared/MSSM/synFile.txt" -z -r "None" -s "HomoSapiens" -t "CDR0_1" -u "FP" -x "/shared/metanetworkSynapse/pushSparseNetworkSynapse.R"

#FP CASE
echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMfpCase.sh" > codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/generateConsensusNetworks.sh" >> codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/pushRankConsensus.sh" >> codeFile.txt

aws s3 cp s3://metanetworks/MSSM/FP/CDR2_5/result_rankConsensus.rda /shared/MSSM/
aws s3 cp s3://metanetworks/MSSM/FP/CDR2_5/sparsity.csv /shared/MSSM/
/shared/metanetworkSynapse/pushNet.sh -a "syn5016948" -b "/shared/MSSM/codeFile.txt" -c "/shared/MSSM/synFile.txt" -z -r "None" -s "HomoSapiens" -t "CDR2_5" -u "FP" -x "/shared/metanetworkSynapse/pushSparseNetworkSynapse.R"

#STG CONTROL
echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMstgControl.sh" > codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/generateConsensusNetworks.sh" >> codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/pushRankConsensus.sh" >> codeFile.txt

aws s3 cp s3://metanetworks/MSSM/STG/CDR0_1/result_rankConsensus.rda /shared/MSSM/
aws s3 cp s3://metanetworks/MSSM/STG/CDR0_1/sparsity.csv /shared/MSSM/
/shared/metanetworkSynapse/pushNet.sh -a "syn5016951" -b "/shared/MSSM/codeFile.txt" -c "/shared/MSSM/synFile.txt" -z -r "None" -s "HomoSapiens" -t "CDR0_1" -u "STG" -x "/shared/metanetworkSynapse/pushSparseNetworkSynapse.R"

#STG CASE
echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMstgCase.sh" > codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/generateConsensusNetworks.sh" >> codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/pushRankConsensus.sh" >> codeFile.txt

aws s3 cp s3://metanetworks/MSSM/STG/CDR2_5/result_rankConsensus.rda /shared/MSSM/
aws s3 cp s3://metanetworks/MSSM/STG/CDR2_5/sparsity.csv /shared/MSSM/
/shared/metanetworkSynapse/pushNet.sh -a "syn5016952" -b "/shared/MSSM/codeFile.txt" -c "/shared/MSSM/synFile.txt" -z -r "None" -s "HomoSapiens" -t "CDR2_5" -u "STG" -x "/shared/metanetworkSynapse/pushSparseNetworkSynapse.R"

#PHG CONTROL
echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMphgControl.sh" > codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/generateConsensusNetworks.sh" >> codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/pushRankConsensus.sh" >> codeFile.txt

aws s3 cp s3://metanetworks/MSSM/PHG/CDR0_1/result_rankConsensus.rda /shared/MSSM/
aws s3 cp s3://metanetworks/MSSM/PHG/CDR0_1/sparsity.csv /shared/MSSM/
/shared/metanetworkSynapse/pushNet.sh -a "syn5016949" -b "/shared/MSSM/codeFile.txt" -c "/shared/MSSM/synFile.txt" -z -r "None" -s "HomoSapiens" -t "CDR0_1" -u "PHG" -x "/shared/metanetworkSynapse/pushSparseNetworkSynapse.R"

#PHG CASE
echo "https://github.com/blogsdon/MSSM/blob/master/runMSSMphgCase.sh" > codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/generateConsensusNetworks.sh" >> codeFile.txt
echo "https://github.com/blogsdon/MSSM/blob/master/pushRankConsensus.sh" >> codeFile.txt

aws s3 cp s3://metanetworks/MSSM/PHG/CDR2_5/result_rankConsensus.rda /shared/MSSM/
aws s3 cp s3://metanetworks/MSSM/PHG/CDR2_5/sparsity.csv /shared/MSSM/
/shared/metanetworkSynapse/pushNet.sh -a "syn5016950" -b "/shared/MSSM/codeFile.txt" -c "/shared/MSSM/synFile.txt" -z -r "None" -s "HomoSapiens" -t "CDR2_5" -u "PHG" -x "/shared/metanetworkSynapse/pushSparseNetworkSynapse.R"

