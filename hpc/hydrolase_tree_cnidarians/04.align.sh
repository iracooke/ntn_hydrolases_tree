
for f in *.gff;do cat ${f%.gff}.faa;done > all.faa
for f in *.gff;do cat ${f%.gff}.fna;done > all.fna

# Removing highly divergent sequence 'XP_015779111.1'
cat cds_2_prot.csv | awk -F ',' '{print $3}' | grep -v -e 'protein_id' -e 'XP_015779111.1' | grep -v 'mcac' | xargs -I{} samtools faidx all.faa {} > hydrolases.faa

cat cds_2_prot.csv | awk -F ',' '{print $4}' | grep -v 'cds_id' | xargs -I{} samtools faidx all.fna {} > hydrolases.fna

# We remove the mcac sequences. Now add the mcap ones manually

cat mcap_dh.faa >> hydrolases.faa

mafft --maxiterate 1000 --genafpair hydrolases.faa > hydrolases_aligned.faa