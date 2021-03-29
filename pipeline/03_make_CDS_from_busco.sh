#!/usr/bin/bash
#SBATCH -p short -N 1 -n 24 --mem 24gb --out logs/make_busco_CDS.%a.log
module load miniconda3
module load exonerate/2.4.0

CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi

N=${SLURM_ARRAY_TASK_ID}

if [ -z $N ]; then
  N=$1
  if [ -z $N ]; then
    echo "need to provide a number by --array or cmdline"
    exit
  fi
fi

python3 ./scripts/busco_to_phyling.py --temp /scratch/$USER.$$ --arrayjob $N --threads $CPU

rm -rf /scratch/$USER.$$
