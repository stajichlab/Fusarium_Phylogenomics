#!/usr/bin/bash

N=1
DAT=()
for n in $(ls genomes/*.dna.fasta)
do
	b=$(basename $n .dna.fasta)
	if [ ! -d BUSCO/$b ]; then
		DAT+=( $N )
	fi
	N=$(expr $N + 1)
done
printf -v joined '%s,' "${DAT[@]}"

echo "sbatch -a ${joined%,} pipeline/02_busco.sh"
