#!/usr/bin/bash
#SBATCH -p batch,intel,stajichlab -N 1 -n 2 --mem 64gb --out logs/ASTRAL.log

source config.txt

NUM=$(wc -l prefix.tab | awk '{print $1}')
MEM=64g
module load java
module load ASTRAL

CDSGENETREES=${PREFIX}.${NUM}_taxa.$HMM.CDS.gene_trees.tre
PEPGENETREES=${PREFIX}.${NUM}_taxa.$HMM.aa.gene_trees.tre
CDSCONSTREE=$(basename $CDSGENETREES .gene_trees.tre)".astral.tre"
PEPCONSTREE=$(basename $PEPGENETREES .gene_trees.tre)".astral.tre"

if [ ! -f $CDSGENETREES ]; then
    cat ${ALN_OUTDIR}/$HMM/*.cds.clipkit.FT.tre > $CDSGENETREES
fi

if [ ! -f $PEPGENETREES ]; then
    cat ${ALN_OUTDIR}/$HMM/*.aa.clipkit.FT.tre > $PEPGENETREES
fi

echo "$CDSGENETREES -o $CDSCONSTREE"

if [ ! -s $CDSCONSTREE ]; then
    java -Xmx${MEM} -jar $ASTRALJAR -i $CDSGENETREES -o $CDSCONSTREE
fi

echo " -i $PEPGENETREES -o $PEPCONSTREE"
if [ ! -s $PEPCONSTREE ]; then
    java -Xmx${MEM} -jar $ASTRALJAR -i $PEPGENETREES -o $PEPCONSTREE
fi
