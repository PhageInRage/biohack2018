# argument 1: file where each line is a patient sam file prefix

for name in $(cat $1)
do
grep "NC_" ${name}.sam \
| awk '{print $3}' \
| sort \
| uniq -c \
| sort -nk1 \
| grep "NC_" \
| tail > ${name}.txt
done
