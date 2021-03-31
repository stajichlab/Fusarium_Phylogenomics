#!/usr/bin/bash
#SBATCH -p short -n 32 --mem 120gb  -N 1 --out logs/make_CDS_trees.logs
module load fastree
module load IQ-TREE/2.1.1

CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

make -f PHYling_unified/util/makefiles/Makefile.trees HMM=sordariomycetes_odb10.2021 CDS -j $CPU
