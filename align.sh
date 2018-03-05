# argument 1: file where each line is a patient fastq files prefix
# argument 2: prefix of the reference to be align on

for name in $(cat $1)
do
echo $name
bowtie2 -x $2 \
-1 ${name}_1.fastq \
-2 ${name}_2.fastq \
-S ${name}.sam
done
