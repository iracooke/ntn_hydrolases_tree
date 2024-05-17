for f in amil.gff	dper.gff	hsym.gff	hvul.gff	ofav.gff	pdam.gff	spis.gff;do
	species=${f%.gff}
	echo $species
	cat ${species}.gff | \
		sed -E 's/.*ID=cds-([^;]*).*/\1/' | \
		sort -u | \
		xargs -I{} grep {} ${species}.fna | \
		awk '{print $1}' | sed 's/>//' | \
		xargs -I{} samtools faidx ${species}.fna {} > ${species}_hydrolases.fna

	cat ${species}_blastp_results.tsv | awk '{print $2}' | xargs -I{} samtools faidx ${species}.faa {} > ${species}_hydrolases.faa
done


for f in adig.gff aten.gff;do
	species=${f%.gff}
	echo $species
	cat ${species}.gff | sed -E 's/.*ID=([^;]*).*/\1/' | sort -u | xargs -I{} grep {} ${species}.fna | awk '{print $1}' | sed 's/>//' | xargs -I{} samtools faidx ${species}.fna {} > ${species}_hydrolases.fna
	cat ${species}.gff | sed -E 's/.*ID=([^;]*).*/\1/' | sort -u | sed 's/>//' | xargs -I{} samtools faidx ${species}.faa {} > ${species}_hydrolases.faa
done

# cat aten.gff | sed -E 's/.*ID=([^;]*).*/\1/' | sort -u | xargs -I{} grep {} aten.fna | awk '{print $1}' | sed 's/>//' | xargs -I{} samtools faidx aten.fna {} > aten_hydrolases.fna

cat mcac.gff | sed -E 's/.*transcript_id \"([^\"]*).*/\1/' | sort -u | xargs -I{} grep {} mcac.fna | awk '{print $1}' | sed 's/>//' | xargs -I{} samtools faidx mcac.fna {} > mcac_hydrolases.fna
cat mcac.gff | sed -E 's/.*transcript_id \"([^\"]*).*/\1/' | sort -u | sed 's/>//' | xargs -I{} samtools faidx mcac.faa {} > mcac_hydrolases.faa

cat *_hydrolases.faa | bioawk -c fastx '{OFS="\t";print $name,length($seq)}' > prot_lengths.tsv
cat *_hydrolases.fna | bioawk -c fastx '{OFS="\t";print $name,length($seq)}' > cds_lengths.tsv
