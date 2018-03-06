# argument 1: file where each line is a patient prefix

for name in $(cat $1)
do
fastq-dump --split-3 $name
done
