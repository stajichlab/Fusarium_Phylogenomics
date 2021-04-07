#!/usr/bin/bash
#SBATCH -p short

bash scripts/get_ncbi_datasets.sh
./scripts/assembly_json_process.py --infile lib/ncbi_accessions.json --outfile lib/ncbi_accessions.csv
./scripts/assembly_json_process.py --infile lib/ncbi_accessions_outgroups.json --outfile lib/ncbi_accessions_outgroups.csv

perl -i -p -e 's/\r\n/\n/g' lib/ncbi_accessions.csv lib/ncbi_accessions_outgroups.csv

#perl scripts/make_taxonomy_table.pl lib/ncbi_accessions.csv > lib/ncbi_accessions_taxonomy.csv
