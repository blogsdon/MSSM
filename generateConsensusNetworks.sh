#!/bin/bash

qsub -v method="methods.txt",s3path="s3://metanetworks/MSSM/FP/CDR0_1/" -pe orte 16 -S /bin/bash -V -cwd -N fpcdr01cons -e /shared/MSSM/fpcdr01error.txt -o /shared/MSSM/fpcdr01out.txt /shared/metanetworkSynapse/pushConsensus.sh

qsub -v method="methods.txt",s3path="s3://metanetworks/MSSM/FP/CDR2_5/" -pe orte 16 -S /bin/bash -V -cwd -N fpcdr25cons -e /shared/MSSM/fpcdr25error.txt -o /shared/MSSM/fpcdr25out.txt /shared/metanetworkSynapse/pushConsensus.sh

qsub -v method="methods.txt",s3path="s3://metanetworks/MSSM/STG/CDR0_1/" -pe orte 16 -S /bin/bash -V -cwd -N stgcdr01cons -e /shared/MSSM/stgcdr01error.txt -o /shared/MSSM/stgcdr01out.txt /shared/metanetworkSynapse/pushConsensus.sh

qsub -v method="methods.txt",s3path="s3://metanetworks/MSSM/STG/CDR2_5/" -pe orte 16 -S /bin/bash -V -cwd -N stgcdr25cons -e /shared/MSSM/stgcdr25error.txt -o /shared/MSSM/stgcdr25out.txt /shared/metanetworkSynapse/pushConsensus.sh

qsub -v method="methods.txt",s3path="s3://metanetworks/MSSM/PHG/CDR0_1/" -pe orte 16 -S /bin/bash -V -cwd -N phgcdr01cons -e /shared/MSSM/phgcdr01error.txt -o /shared/MSSM/phgcdr01out.txt /shared/metanetworkSynapse/pushConsensus.sh

qsub -v method="methods.txt",s3path="s3://metanetworks/MSSM/PHG/CDR2_5/" -pe orte 16 -S /bin/bash -V -cwd -N phgcdr25cons -e /shared/MSSM/phgcdr25error.txt -o /shared/MSSM/phgcdr25out.txt /shared/metanetworkSynapse/pushConsensus.sh
