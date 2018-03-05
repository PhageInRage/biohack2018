#argument 1: file where each line is a patient fastq files prefix
#argument 2: path to trimmomatic jar

for name in $(cat $1)
do
java -jar $2 PE \
-threads 4  -phred33 -trimlog trimlog.txt \
${name}_1.fastq ${name}_2.fastq \
${name}_trimmed_1.fastq \
${name}_trimmed_2.fastq \
${name}_trimmed_3.fastq \
${name}_trimmed_4.fastq \
ILLUMINACLIP:TruSeq3-PE-2.fa:3:30:7:2 \
TRAILING:25 AVGQUAL:20 MINLEN:50
done
