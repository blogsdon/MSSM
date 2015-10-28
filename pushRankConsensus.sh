#!/bin/bash


#push all rank consensus networks to Synapse
echo "" > codeFile.txt
echo "" >> codeFile.txt
echo "" > synFile.txt
echo "" >> synFile.txt
aws s3 cp s3://metanetworks/MSSM/FP/CDR0_1/result_rankConsensus.rda /shared/MSSM/
/shared/metanetworkSynapse/pushNet.sh -a "syn4545005" -b "/shared/ROSMAP/codeFile.txt" -c "/shared/ROSMAP/synFile.txt" -z -r "None" -s "HomoSapiens" -t "Control" -u "FP" -x "/shared/metanetworkSynapse/pushSparseNetworkSynapse.R"
