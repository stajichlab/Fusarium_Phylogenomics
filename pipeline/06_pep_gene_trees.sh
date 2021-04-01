#!/usr/bin/bash
#SBATCH -p short -n 8 --mem 32gb  -N 1 --out logs/make_pep_trees.%A.log
module load fasttree
module load IQ-TREE/2.1.1

CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
make -f PHYling_unified/util/makefiles/Makefile.trees HMM=sordariomycetes_odb10.2021 -j $CPU PEP

