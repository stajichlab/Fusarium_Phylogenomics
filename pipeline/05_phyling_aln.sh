#!/usr/bin/bash
#SBATCH --ntasks 2 --mem 24G --time 2:00:00 -p short -N 1
module load parallel
module load hmmer/3

module load miniconda3
if [ ! -f config.txt ]; then
    echo "Need config.txt for PHYling"
    exit
fi

source config.txt

if [ ! -z $PREFIX ]; then
    rm -rf aln/$PREFIX
fi
# probably should check to see if allseq is newer than newest file in the folder?
echo " I will remove prefix.tab to make sure it is regenerated"
#rm prefix.tab
./PHYling_unified/PHYling aln -c -q slurm
