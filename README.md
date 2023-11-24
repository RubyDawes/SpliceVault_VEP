# SpliceVault VEP Plugin

The SpliceVault VEP annotates Single Nucleotide Polymorphisms (SNPs) that are predicted to decrease the strength of annotated splice-sites by SpliceAI (DL > 0.2 or AL > 0.2 in precomputed scores). For these variants, SpliceVault can provide information on the likely mis-splicing outcomes for the transcript and whether these outcomes will cause a frameshift.

## VEP Output Columns Added by SpliceVault Plugin
### SpliceVault_site
- the splice-site predicted to be lost by SpliceAI. Format: `{splice_site_lost (donor or acceptor)}|chrom:position`
- Cryptic positions are relative to this genomic coordinate.

### SpliceVault_out_of_frame_events
- The fraction of the Top4 events which cause a frameshift in the format:  
  `Frameshift: {number of Top4 events causing frameshift}/{either 4, or the total number of mis-splicing events detected at this site if less than 4}`
- As reported in Dawes et al ([link](https://www.nature.com/articles/s41588-022-01293-8)), sites with 3/4 or more in-frame events (or all in-frame events) are likely to be splice-rescue and not LoF


### SpliceVault_Top4_Events
- Details on the Top4 events and how they impact the transcript. Events are pipe-delimited and each event is supplied in the following format:
    - `{event_rank}:{event_type}:{transcript_impact}:{percent_of_samples}:{Frame}`
    - `event_type`:
        - can be ES (Exon Skipping), CD (Cryptic Donor) or CA (Cryptic Acceptor)
    - `transcript_impact`:
        - For Exon Skipping events, records the exon(s) which are skipped. e.g. if the event represents skipping of exon 2 in that transcript the event will be ES:2, if the event represents skipping of exons 2 AND 3, ES:2-3
        - For Cryptic Donor and Acceptor events, records the distance between the annotated splice-site and the cryptic splice-site with reference to the transcript (Note: this means transcripts on the negative strand will still have distances reported according to the 5’ to 3’ distance.)
    - `percent_of_samples`:
        - percent of samples this event is seen in, relative to annotated splicing. Note this may be above 100% if the event is seen in more samples than annotated splicing.

### SpliceVault_site_info
- SpliceVault is based on Genotype-Tissue Expression (GTEx) and Sequence Read Archive (SRA) RNA-seq data. Some splice-sites may not be well covered, making missing events more likely so we report the sample count for this splice-site and the maximum number of reads seen in any one sample representing annotated splicing in GTEx.
- This information is provided if you wish to only consider Top4 events for splice-sites seen in some minimum number of samples or to some minimum depth in GTEx.
