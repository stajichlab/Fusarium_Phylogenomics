#!/usr/bin/bash
#SBATCH -p batch,intel -n 8 -N 1 --mem 16gb --out logs/busco.%a.log



IN=genomes
OUT=BUSCO
export AUGUSTUS_CONFIG_PATH=/bigdata/stajichlab/shared/pkg/augustus/3.3/config
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

if [ ! -d $OUT ]; then
  mkdir -p $OUT
fi



INFILE=$(ls $IN/*.dna.fasta | sed -n ${N}p)
BASE=$(basename $INFILE .dna.fasta)

if [ ! -d $OUT/$BASE ]; then
  module load busco/5.0.0
  busco -m genome -l sordariomycetes_odb10 -c $CPU -o $BASE --out_path $OUT --offline --augustus_species fusarium --in $INFILE --download_path $BUSCO_LINEAGES
fi
