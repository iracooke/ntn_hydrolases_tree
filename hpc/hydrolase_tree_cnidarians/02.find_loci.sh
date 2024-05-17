
while IFS="," read -a f;do 
	acc=${f[0]}; 
	species=${f[1]}; 
	cat ${species}_blastp_results.tsv | awk '{print $2}' | xargs -I{} grep {} download/${acc}/genomic.gff | sort -u > ${species}.gff
done < species.csv


