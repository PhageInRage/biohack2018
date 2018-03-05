# Biohack 2018 phages in rage pipeline

The analysis require two fastq file for each patient (pair-start fastq and pair-end fastq). They should be named as follows: `PATIENT_UNIQUE_PREFIX_1.fastq` and `PATIENT_UNIQUE_PREFIX_2.fastq`.

First of all metagenomes is aligned on references index (phages or bacteria fastq) using `align.sh`.

References ratio for each patient could be retrieved using `analyse_references_ratio.sh`.

References ratio for all patiens could be aggregated by `analysis/humans_references_ratio.R`.

And then the correlation heat map can be shown by `analysis/correlation_heat_map.R` (or normalized correlation heat map `analysis/normalized_correlation_heat_map.R`).