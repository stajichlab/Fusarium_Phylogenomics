#!/usr/bin/bash
#SBATCH -p short --out logs/download.%a.log
module load aspera
#DAT=(lib/ncbi_accessions_Fusarium.csv lib/ncbi_accessions_outgroups.csv)
DAT=(lib/ncbi_accessions_outgroups.csv)
#ACCESSION,SPECIES,STRAIN,NCBI_TAXID,BIOPROJECT,N50,ASM_NAME
OUT=source/NCBI_ASM
IFS=,
for file in ${DAT[@]}; 
do
    tail -n +2 $file | while read ACCESSION SPECIES STRAIN TAXID BIOPROJECT N50 ASMNAME
    do
	PRE=$(echo $ACCESSION | cut -d_ -f1 )
	ONE=$(echo $ACCESSION | cut -d_ -f2 | awk '{print substr($1,1,3)}')
	TWO=$(echo $ACCESSION | cut -d_ -f2 | awk '{print substr($1,4,3)}')
	THREE=$(echo $ACCESSION | cut -d_ -f2 | awk '{print substr($1,7,3)}')
	ASMNAME=$(echo $ASMNAME | perl -p -e 's/ /_/g')
	echo "anonftp@ftp.ncbi.nlm.nih.gov:/genomes/all/$PRE/$ONE/$TWO/$THREE/${ACCESSION}_$ASMNAME/"
	if [ ! -d $OUT/${ACCESSION}_$ASMNAME ]; then
	    ascp -k1 -Tdr -l400M -i $ASPERAKEY --overwrite=diff anonftp@ftp.ncbi.nlm.nih.gov:/genomes/all/$PRE/$ONE/$TWO/$THREE/${ACCESSION}_$ASMNAME ./$OUT/
	fi	
    done
done
