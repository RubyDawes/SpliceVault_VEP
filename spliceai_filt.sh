gunzip -c spliceai_scores.masked.snv.hg38.vcf.gz | awk -F'\t' '!/^#/{split($NF, a, "|"); if (a[4] > 0.2 || a[6] > 0.2) print}' | gzip > spliceai_ssloss.txt.gz