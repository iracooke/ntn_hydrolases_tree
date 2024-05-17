
for species in $(cat species.csv | grep -v 'species' | awk -F ',' '{print $2}' | tr '\n' ' ');do
	if [[ -f  ${species}_blastp_results.tsv ]]; then
		echo "$species is done"
	else
		echo $species
		makeblastdb -in ${species}.faa -dbtype 'prot'
		blastp -db $species.faa -query Cluster012104_hydrolase_cloned_aa.fasta -outfmt '6 std staxid ssciname' -max_hsps 1 -evalue 0.00001 > ${species}_blastp_results.tsv
	fi
done


